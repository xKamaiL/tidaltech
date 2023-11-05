
#include "time_sync.h"

#include "esp_log.h"
#include "esp_sntp.h"
#include "led.h"

static const char* TAG = "TimeSync";

void time_sync_notification_cb(struct timeval* tv) {
    ESP_LOGI(TAG, "Time synchronized: %lld", tv->tv_sec);

    // Update ESP32 internal RTC
    struct timeval set_time = {
        .tv_sec = tv->tv_sec,
        .tv_usec = tv->tv_usec};
    settimeofday(&set_time, NULL);

    // Update LED when start
    tm now = obtain_time();
    led_display(now);
}

void initialize_sntp() {
    ESP_LOGI(TAG, "Initializing SNTP");
    esp_sntp_setoperatingmode(SNTP_OPMODE_POLL);
    esp_sntp_setservername(0, NTP_SERVER);
    esp_sntp_init();

    sntp_set_time_sync_notification_cb(time_sync_notification_cb);
}

tm obtain_time() {
    time_t now = 0;
    struct tm timeinfo = {0};
    time(&now);
    localtime_r(&now, &timeinfo);
    // Change to GMT+7
    timeinfo.tm_hour = timeinfo.tm_hour + TIMEZONE;
    if (timeinfo.tm_hour >= 24) {
        timeinfo.tm_hour = timeinfo.tm_hour - 24;
    }
    return timeinfo;
}