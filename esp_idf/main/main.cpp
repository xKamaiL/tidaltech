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
#include "wifi_manager.h"  // tidal tech wifi manager

#define NTP_SERVER "pool.ntp.org"
#include "esp_sntp.h"
#include "time.h"

static const char *TAG = "Time Sync";
static void initialize_sntp() {
    ESP_LOGI(TAG, "Initializing SNTP");
    sntp_setoperatingmode(SNTP_OPMODE_POLL);
    sntp_setservername(0, NTP_SERVER);
    sntp_init();
}

static void obtain_time() {
    time_t now = 0;
    struct tm timeinfo = {0};

    time(&now);
    localtime_r(&now, &timeinfo);

    // Change to GMT+7
    timeinfo.tm_hour = timeinfo.tm_hour + 7;
    if (timeinfo.tm_hour >= 24) {
        timeinfo.tm_hour = timeinfo.tm_hour - 24;
    }
    // Print current time
    ESP_LOGI(TAG, "Current time: %02d:%02d:%02d", timeinfo.tm_hour, timeinfo.tm_min, timeinfo.tm_sec);
}

extern "C" {
void app_main(void);
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
    // initialize_sntp();
}
