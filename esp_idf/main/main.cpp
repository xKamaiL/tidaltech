#include <inttypes.h>
#include <stdio.h>

#include <string>

#include "ble_manager.h"  // tidal tech ble manager
#include "esp_log.h"
#include "led.h"
#include "light_mode.h"
#include "nvs.h"
#include "nvs_flash.h"
#include "schedule.h"
#include "sdkconfig.h"
#include "time_sync.h"
#include "wifi_manager.h"  // tidal tech wifi manager

#define NTP_SERVER "pool.ntp.org"
#include "esp_sntp.h"
#include "time.h"

extern "C" {
void app_main(void);
}

void daily_task(void* param) {
    while (true) {
        tm now = obtain_time();

        // check if stn is synced

        // Print current time
        printf("Current time: %02d:%02d:%02d\n", now.tm_hour, now.tm_min, now.tm_sec);

        int next = (60 - now.tm_sec);
        if (next == 0) {
            next = 5;  // wait 5 seconds if we are at the top of the minute
        }

        // sntp_get_sync_status() == SNTP_SYNC_STATUS_IN_PROGRESS

        // output to led with current time condition
        led_display(now);

        printf("\ndelay for %d seconds\n\n", next);
        vTaskDelay(pdMS_TO_TICKS(next * 1000));
    }
}

void app_main(void) {
    esp_err_t err = nvs_flash_init();
    if (err == ESP_ERR_NVS_NO_FREE_PAGES || err == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_ERROR_CHECK(nvs_flash_erase());
        err = nvs_flash_init();
    }
    ESP_ERROR_CHECK(err);
    initialise_wifi();
    initNimble();
    initialize_led();

    xTaskCreate(daily_task, "daily_task", 4096, NULL, 1, NULL);
}

#include "esp_netif_sntp.h"
#include "esp_sntp.h"
#include "esp_system.h"
#include "lwip/ip_addr.h"
