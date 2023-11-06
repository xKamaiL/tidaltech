#include <stdlib.h>
#include <string.h>

#include "esp_event.h"
#include "esp_log.h"
#include "esp_netif.h"
#include "esp_smartconfig.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_wpa2.h"
#include "freertos/FreeRTOS.h"
#include "freertos/event_groups.h"
#include "freertos/task.h"
#include "nvs_flash.h"
#include "time_sync.h"

const char* TAG = "wifi_manager";

void initialise_wifi(void);

/* FreeRTOS event group to signal when we are connected & ready to make a request */
static EventGroupHandle_t s_wifi_event_group;

/* The event group allows multiple bits for each event,
   but we only care about one event - are we connected
   to the AP with an IP? */
static const int CONNECTED_BIT = BIT0;
static const int ESPTOUCH_DONE_BIT = BIT1;

static void smartconfig_example_task(void* parm);

static int s_retry_num = 0;

void disconnect_wifi(void) {
    wifi_config_t conf;
    esp_err_t ret;
    ret = esp_wifi_get_config(WIFI_IF_STA, &conf);
    if (ret != ESP_OK) {
        printf("wifi retry: get config failed\n");
        return;
    }
    conf.sta.ssid[0] = '\0';
    conf.sta.password[0] = '\0';
    esp_wifi_set_config(WIFI_IF_STA, &conf);
    esp_wifi_disconnect();
    esp_wifi_start();
    printf("Wifi disconnected, restarting: %d\n", s_retry_num);
}

static void event_handler(void* arg, esp_event_base_t event_base,
                          int32_t event_id, void* event_data) {
    if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_START) {
        xTaskCreate(smartconfig_example_task, "smartconfig_example_task", 4096, NULL, 3, NULL);
    } else if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_DISCONNECTED) {
        if (s_retry_num < 5) {
            printf("Wifi disconnected, reconnecting: %d\n", s_retry_num);
            esp_wifi_connect();
            s_retry_num++;
            if (s_retry_num >= 4) {
                disconnect_wifi();
            }
        }
        xEventGroupClearBits(s_wifi_event_group, CONNECTED_BIT);
        ESP_LOGI(TAG, "connect to the AP fail");
    } else if (event_base == IP_EVENT && event_id == IP_EVENT_STA_GOT_IP) {
        printf("Got IP\n");
        xEventGroupSetBits(s_wifi_event_group, CONNECTED_BIT);
        initialize_sntp();
        s_retry_num = 0;  // reset retry counter
    } else if (event_base == SC_EVENT && event_id == SC_EVENT_SCAN_DONE) {
        printf("Scan done\n");
    } else if (event_base == SC_EVENT && event_id == SC_EVENT_FOUND_CHANNEL) {
        printf("Found channel\n");
    } else if (event_base == SC_EVENT && event_id == SC_EVENT_GOT_SSID_PSWD) {
        printf("Got SSID and password\n");

        smartconfig_event_got_ssid_pswd_t* evt = (smartconfig_event_got_ssid_pswd_t*)event_data;
        wifi_config_t wifi_config;
        uint8_t ssid[33] = {0};
        uint8_t password[65] = {0};
        uint8_t rvd_data[33] = {0};

        bzero(&wifi_config, sizeof(wifi_config_t));
        memcpy(wifi_config.sta.ssid, evt->ssid, sizeof(wifi_config.sta.ssid));
        memcpy(wifi_config.sta.password, evt->password, sizeof(wifi_config.sta.password));
        wifi_config.sta.bssid_set = evt->bssid_set;
        if (wifi_config.sta.bssid_set == true) {
            memcpy(wifi_config.sta.bssid, evt->bssid, sizeof(wifi_config.sta.bssid));
        }

        memcpy(ssid, evt->ssid, sizeof(evt->ssid));
        memcpy(password, evt->password, sizeof(evt->password));
        printf("SSID:%s\n", ssid);
        printf("PASSWORD:%s\n", password);
        if (evt->type == SC_TYPE_ESPTOUCH_V2) {
            ESP_ERROR_CHECK(esp_smartconfig_get_rvd_data(rvd_data, sizeof(rvd_data)));
            printf("RVD_DATA:");
            for (int i = 0; i < 33; i++) {
                printf("%02x ", rvd_data[i]);
            }
            printf("\n");
        }

        ESP_ERROR_CHECK(esp_wifi_disconnect());
        ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_STA, &wifi_config));
        esp_wifi_connect();
    } else if (event_base == SC_EVENT && event_id == SC_EVENT_SEND_ACK_DONE) {
        xEventGroupSetBits(s_wifi_event_group, ESPTOUCH_DONE_BIT);
    }
}

void initialise_wifi(void) {
    ESP_ERROR_CHECK(esp_netif_init());
    s_wifi_event_group = xEventGroupCreate();
    ESP_ERROR_CHECK(esp_event_loop_create_default());
    esp_netif_t* sta_netif = esp_netif_create_default_wifi_sta();
    assert(sta_netif);

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));

    ESP_ERROR_CHECK(esp_event_handler_register(WIFI_EVENT, ESP_EVENT_ANY_ID, &event_handler, NULL));
    ESP_ERROR_CHECK(esp_event_handler_register(IP_EVENT, IP_EVENT_STA_GOT_IP, &event_handler, NULL));
    ESP_ERROR_CHECK(esp_event_handler_register(SC_EVENT, ESP_EVENT_ANY_ID, &event_handler, NULL));

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA));
    ESP_ERROR_CHECK(esp_wifi_start());

    wifi_config_t conf;
    esp_err_t ret;
    ret = esp_wifi_get_config(WIFI_IF_STA, &conf);
    if (ret == ESP_OK) {
        ESP_LOGI(TAG, "Wifi configuration already stored in flash partition called NVS");
        if (conf.sta.ssid[0] == '\0') {
            ESP_LOGI(TAG, "Wifi configuration not found, starting smartconfig");
        } else {
            ESP_LOGI(TAG, "Wifi configuration found, connecting to %s", conf.sta.ssid);
            ESP_ERROR_CHECK(esp_wifi_disconnect());
            ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_STA, &conf));
            esp_wifi_connect();
        }
    } else {
        ESP_LOGI(TAG, "Wifi configuration not found, starting smartconfig");
    }
}

static void smartconfig_example_task(void* parm) {
    printf("smartconfig: start task\n");
    EventBits_t uxBits;
    esp_err_t err = esp_smartconfig_set_type(SC_TYPE_ESPTOUCH);
    if (err != ESP_OK) {
        printf("smartconfig: set type fail %d\n", err);
        vTaskDelete(NULL);
        return;
    }
    smartconfig_start_config_t cfg = SMARTCONFIG_START_CONFIG_DEFAULT();
    if (esp_smartconfig_start(&cfg) != ESP_OK) {
        printf("smartconfig: start fail\n");
        vTaskDelete(NULL);
        return;
    }
    while (1) {
        uxBits = xEventGroupWaitBits(s_wifi_event_group, CONNECTED_BIT | ESPTOUCH_DONE_BIT, true, false, portMAX_DELAY);
        if (uxBits & CONNECTED_BIT) {
            printf("smartconfig: wifi connected\n");
        }
        if (uxBits & ESPTOUCH_DONE_BIT) {
            printf("smartconfig over");
            esp_smartconfig_stop();
            vTaskDelete(NULL);
        }
    }
}
