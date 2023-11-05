#include "callback.h"

#include "NimBLEDevice.h"
#include "esp_log.h"
#include "esp_wifi.h"
#include "light_mode.h"
#include "proto/message.pb-c.h"
#include "schedule.h"

static const char *TAG = "callback";

void on_add_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    LightingScheduleRequest *req = lighting_schedule_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("addColorTimePoint: decode message failed\n");
        return;
    }

    unsigned short hh = req->hh;
    unsigned short mm = req->mm;

    LEDLevel leds;
    leds.white = req->white;
    leds.warm_white = req->warm_white;
    leds.red = req->red;
    leds.green = req->green;
    leds.blue = req->blue;
    leds.royal_blue = req->royal_blue;
    leds.ultra_violet = req->ultra_violet;
    lighting_schedule_request__free_unpacked(req, NULL);

    std::vector<Schedule> schedules;
    esp_err_t err = read_schedule_from_nvs(schedules);
    if (err != ESP_OK) {
        printf("addColorTimePoint: read schedule failed\n");
        return;
    }
    upsert_schedules(schedules, {true, hh, mm, leds});

    err = write_schedule_to_nvs(schedules);
    schedules.clear();
    schedules.shrink_to_fit();
    if (err != ESP_OK) {
        printf("addColorTimePoint: write schedule failed\n");
        return;
    }
    return;
}

void on_available_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    ListTimePointRequest *req = list_time_point_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("onAvailableColorTimePoints: decode message failed\n");
        return;
    }

    std::vector<Schedule> schedules;
    esp_err_t err = read_schedule_from_nvs(schedules);
    if (err != ESP_OK) {
        list_time_point_request__free_unpacked(req, NULL);
        printf("onAvailableColorTimePoints: read schedule failed\n");
        return;
    }

    schedules = filter_schedules(schedules, [&](const Schedule &s) {
        for (size_t i = 0; i < req->n_times; ++i) {
            unsigned short hh = req->times[i]->hh;
            unsigned short mm = req->times[i]->mm;
            if (s.hh == hh && s.mm == mm) {
                return true;
            }
        }
        return false;
    });

    list_time_point_request__free_unpacked(req, NULL);

    err = write_schedule_to_nvs(schedules);
    schedules.clear();
    schedules.shrink_to_fit();
    if (err != ESP_OK) {
        printf("onAvailableColorTimePoints: write schedule failed\n");
        return;
    }

    debug_schedules();

    return;
}

void on_set_color_mode(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    SetColorModeRequest *req = set_color_mode_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("onSetColorMode: decode message failed\n");
        return;
    }

    Mode mode = req->mode;
    set_color_mode_request__free_unpacked(req, NULL);

    int saveMode = mode == MODE__MODE_MANUAL ? LIGHT_MODE_MANUAL : LIGHT_MODE_SCHEDULE;

    printf("onSetColorMode: %d\n", saveMode);

    esp_err_t err = write_light_mode_to_nvs(saveMode);
    if (err != ESP_OK) {
        printf("onSetColorMode: write mode failed\n");
        return;
    }

    // TODO: trigger some function ?
}

void on_set_ambient(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    SetAmbientRequest *req = set_ambient_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("onSetAmbient: decode message failed\n");
        return;
    }
    int r = req->r;
    int g = req->g;
    int b = req->b;
    set_ambient_request__free_unpacked(req, NULL);

    // TODO: change ambient R,G,B color
    // but do not change the current color mode
    printf("onSetAmbient: %d,%d,%d\n", r, g, b);
}

void on_wifi_status(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    //
    wifi_ap_record_t ap_info;
    esp_err_t err = esp_wifi_sta_get_ap_info(&ap_info);
    if (err != ESP_OK) {
        if (err == ESP_ERR_WIFI_NOT_CONNECT) {
            printf("onWifiStatus: not connected\n");
            pCharacteristic->setValue(0);
        } else {
            printf("onWifiStatus: get ap info failed\n");
        }
        return;
    }
    pCharacteristic->setValue(1);
}

void on_wifi_read_ssid(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    wifi_ap_record_t ap_info;
    esp_err_t err = esp_wifi_sta_get_ap_info(&ap_info);
    if (err != ESP_OK) {
        pCharacteristic->setValue("");
        if (err == ESP_ERR_WIFI_NOT_CONNECT) {
            printf("onWifiReadSSID: not connected\n");
        } else {
            printf("onWifiReadSSID: get ap info failed\n");
        }
        return;
    }
    printf("onWifiReadSSID: %s\n", ap_info.ssid);
    pCharacteristic->setValue(ap_info.ssid);
}

void on_wifi_read_ip(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    esp_netif_ip_info_t ip_info;
    esp_err_t err = esp_netif_get_ip_info(esp_netif_get_handle_from_ifkey("WIFI_STA_DEF"), &ip_info);
    if (err != ESP_OK) {
        pCharacteristic->setValue("");
        printf("onWifiReadIP: get ip info failed\n");
        return;
    }
    ESP_LOGI(TAG, "got ip:" IPSTR, IP2STR(&ip_info.ip));

    char ip[16];
    sprintf(ip, IPSTR, IP2STR(&ip_info.ip));

    printf("onWifiReadIP: %s\n", ip);
    pCharacteristic->setValue(ip);
}

void on_wifi_disconnect(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    esp_err_t err = esp_wifi_disconnect();
    if (err != ESP_OK) {
        printf("onWifiDisconnect: disconnect failed\n");
        return;
    }
    nvs_handle_t nvs_handle;
    err = nvs_open("nvs.net80211", NVS_READWRITE, &nvs_handle);
    if (err == ESP_OK) {
        nvs_erase_key(nvs_handle, "sta.authmode");
        nvs_erase_key(nvs_handle, "sta.ssid");
        nvs_erase_key(nvs_handle, "sta.passwd");
        nvs_close(nvs_handle);
        printf("onWifiDisconnect: disconnect success\n");
    } else {
        ESP_LOGE(TAG, "Error (%s) opening NVS handle for wifi_config", esp_err_to_name(err));
    }
    wifi_config_t conf;
    esp_err_t ret;
    ret = esp_wifi_get_config(WIFI_IF_STA, &conf);
    if (ret != ESP_OK) {
        printf("onWifiDisconnect: get config failed\n");
        return;
    }
    conf.sta.ssid[0] = '\0';
    conf.sta.password[0] = '\0';
    esp_wifi_set_config(WIFI_IF_STA, &conf);
    esp_wifi_disconnect();

    esp_wifi_start();
}