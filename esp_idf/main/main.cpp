#include <inttypes.h>
#include <stdio.h>

#include <algorithm>
#include <string>
#include <vector>

#include "ble_manager.h" // tidal tech ble manager
#include "driver/rtc_io.h"
#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include "freertos/task.h"
#include "freertos/timers.h"
#include "light_mode.h"
#include "nvs.h"
#include "nvs_flash.h"
#include "proto/message.pb-c.h"
#include "schedule.h"
#include "sdkconfig.h"
#include "wifi_manager.h" // tidal tech wifi manager
#define STORAGE_SCHEDULE "store"
#include "driver/ledc.h"

#define LEDC_HS_TIMER LEDC_TIMER_0
#define LEDC_HS_MODE LEDC_HIGH_SPEED_MODE
#define LEDC_HS_CH0_GPIO (12)
#define LEDC_HS_CH1_GPIO (14)
#define LEDC_HS_CH2_GPIO (25)
#define LEDC_HS_CH3_GPIO (26)
#define LEDC_HS_CH4_GPIO (27)
#define LEDC_HS_CH5_GPIO (32)
#define LEDC_HS_CH6_GPIO (33)
#define LEDC_HS_CH7_GPIO (15)

/* Handler class for server events */

extern "C"
{
    void app_main(void);
}

void app_main(void)
{
    esp_err_t err = nvs_flash_init();
    if (err == ESP_ERR_NVS_NO_FREE_PAGES || err == ESP_ERR_NVS_NEW_VERSION_FOUND)
    {
        // NVS partition was truncated and needs to be erased
        // Retry nvs_flash_init
        ESP_ERROR_CHECK(nvs_flash_erase());
        err = nvs_flash_init();
    }
    ESP_ERROR_CHECK(err);
    initialise_wifi();
    initNimble();

    ledc_timer_config_t ledc_timer = {
        .speed_mode = LEDC_HS_MODE,
        .duty_resolution = LEDC_TIMER_13_BIT,
        .timer_num = LEDC_HS_TIMER,
        .freq_hz = 500,
        .clk_cfg = LEDC_AUTO_CLK,
    };
    ledc_timer_config(&ledc_timer);

    int gpio_pins[] = {LEDC_HS_CH0_GPIO, LEDC_HS_CH1_GPIO, LEDC_HS_CH2_GPIO, LEDC_HS_CH3_GPIO, LEDC_HS_CH4_GPIO, LEDC_HS_CH5_GPIO, LEDC_HS_CH6_GPIO, LEDC_HS_CH7_GPIO};

    for (int i = 0; i < 8; i++)
    {

        ledc_channel_config_t ledc_channel = {
            .gpio_num = static_cast<gpio_num_t>(i),
            .speed_mode = LEDC_HS_MODE,
            .channel = static_cast<ledc_channel_t>(0),
            .intr_type = LEDC_INTR_FADE_END,
            .timer_sel = LEDC_HS_TIMER,
            .duty = 0,
            .hpoint = 0,
        };
        ledc_channel_config(&ledc_channel);
        ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_0, 4096);
        ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_0);

        // FreeRTOS task
    }

    // std::vector<Schedule> schedules;

    // err = read_schedule_from_nvs(schedules);
    // if (err == ESP_OK)

    // {
    //     for (auto &s : schedules)
    //     {
    //         printf("x");
    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_0, s.leds.red);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_0);

    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_1, s.leds.blue);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_1);

    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_2, s.leds.green);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_2);

    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_3, s.leds.royal_blue);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_3);

    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_4, s.leds.ultra_violet);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_4);

    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_5, s.leds.warm_white);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_5);

    //         // ledc_set_duty(LEDC_HS_MODE, LEDC_CHANNEL_6, s.leds.white);
    //         // ledc_update_duty(LEDC_HS_MODE, LEDC_CHANNEL_6);
    //     }
    // }
    // schedules.clear();

  
}




Mode *read_color_mode_from_nvs()
{
    nvs_handle_t handle2;
    esp_err_t err;

    err = nvs_open(STORAGE_SCHEDULE, NVS_READONLY, &handle2);
    if (err != ESP_OK)
        return NULL;

    return 0;
}


#include <chrono>
#include <thread>
#include "GMT+7.h" //file GMT+7.cpp be current time naka 
#include "schedule.h" // input from schedule.cpp

void checkTimeAndUpdate(NVS& nvs) {     //function check time and update
    while (true) {
        
        std::time_t currentTime = GMT::getCurrentTime(); // getCurrentTime() เป็น function GMT+7.cpp

        // change to hour and minute
        std::tm* ptm = std::localtime(&currentTime);
        int currentHour = ptm->tm_hour;
        int currentMinute = ptm->tm_min;

        // Get scheduled time from schedule.cpp
        std::pair<int, int> scheduledTime = Schedule::getScheduleTime(); // Assuming getScheduleTime() is a function in schedule.cpp

        // Compare time
        if (currentHour != scheduledTime.first || currentMinute != scheduledTime.second) {
            //replace the old time with the new time
            nvs.set(currentTime);
        }

        // Wait for 5 minutes
        std::this_thread::sleep_for(std::chrono::minutes(5));
    }
}

