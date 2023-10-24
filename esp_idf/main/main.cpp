#include <inttypes.h>
#include <stdio.h>

#include <algorithm>
#include <string>
#include <vector>

#include "ble_manager.h"  // tidal tech ble manager
#include "driver/rtc_io.h"
#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include "freertos/task.h"
#include "freertos/timers.h"
#include "nvs.h"
#include "nvs_flash.h"
#include "proto/message.pb-c.h"
#include "schedule.h"
#include "sdkconfig.h"
#include "wifi_manager.h"  // tidal tech wifi manager
#define STORAGE_SCHEDULE "store"

/* Handler class for server events */

extern "C" {
void app_main(void);
}

void app_main(void) {
    esp_err_t err = nvs_flash_init();
    if (err == ESP_ERR_NVS_NO_FREE_PAGES || err == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        // NVS partition was truncated and needs to be erased
        // Retry nvs_flash_init
        ESP_ERROR_CHECK(nvs_flash_erase());
        err = nvs_flash_init();
    }
    ESP_ERROR_CHECK(err);
    initialise_wifi();
    initNimble();

    // FreeRTOS task
}

Mode *read_color_mode_from_nvs() {
    nvs_handle_t handle2;
    esp_err_t err;

    err = nvs_open(STORAGE_SCHEDULE, NVS_READONLY, &handle2);
    if (err != ESP_OK)
        return NULL;

    return 0;
}
