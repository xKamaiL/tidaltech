
#include "led.h"

#include "light_mode.h"
#include "schedule.h"
#include "time.h"

void set_duty(LEDLevel leds);

static int gpio_pins[] = {
    LEDC_HS_CH0_GPIO,  // red
    LEDC_HS_CH1_GPIO,  // green
    LEDC_HS_CH2_GPIO,  // blue
    LEDC_HS_CH3_GPIO,  // white
    LEDC_HS_CH4_GPIO,  // warmWhite
    LEDC_HS_CH5_GPIO,  //
    LEDC_HS_CH6_GPIO,  //
    LEDC_HS_CH7_GPIO,  //
};

void initialize_led() {
    ledc_timer_config_t ledc_timer = {
        .speed_mode = LEDC_HS_MODE,
        .duty_resolution = LEDC_DUTY_RES,
        .timer_num = LEDC_HS_TIMER,
        .freq_hz = LEDC_FREQUENCY,
        .clk_cfg = LEDC_AUTO_CLK,
    };
    ledc_timer_config(&ledc_timer);

    for (int i = 0; i < 8; i++) {
        ledc_channel_config_t ledc_channel = {
            .gpio_num = static_cast<gpio_num_t>(gpio_pins[i]),
            .speed_mode = LEDC_HS_MODE,
            .channel = static_cast<ledc_channel_t>(i),
            .intr_type = LEDC_INTR_DISABLE,
            .timer_sel = LEDC_HS_TIMER,
            .duty = 0,
            .hpoint = 0,
        };
        ESP_ERROR_CHECK(ledc_channel_config(&ledc_channel));
    }
}

void led_display(tm now) {
    int8_t mode;
    esp_err_t err;

    // get current light mode
    err = read_light_mode_from_nvs(&mode);
    if (err != ESP_OK) {
        printf("Error reading light mode from NVS\n");
        return;
    }

    if (mode == LIGHT_MODE_MANUAL) {
        printf("led_display: manual mode\n");
        // get current light configuration

        StaticColor color;
        err = read_static_color_from_nvs(&color);
        if (err != ESP_OK) {
            printf("led_display: Error reading static color from NVS\n");
            return;
        }

        printf("led_display: %d,%d,%d\n", color.r, color.g, color.b);

        // output to led with current time condition
        LEDLevel leds = {0};
        leds.red = color.r;
        leds.green = color.g;
        leds.blue = color.b;
        set_duty(leds);

        return;
    }

    if (mode == LIGHT_MODE_SCHEDULE) {
        printf("led_display: schedule mode\n");
        // get current schedule
        std::vector<Schedule> schedules;
        err = read_schedule_from_nvs(schedules);
        if (err != ESP_OK) {
            printf("Error reading schedule from NVS\n");
            return;
        }

        int hh = now.tm_hour;
        int mm = now.tm_min;

        std::vector<Schedule> next_schedules;

        // find two schedule that bracket current time
        for (auto &s : schedules) {
            if (s.hh <= hh) {
                if (s.hh == hh) {
                    if (s.mm <= mm) {
                        next_schedules.push_back(s);
                    }
                } else {
                    next_schedules.push_back(s);
                }
            }
        }

        if (next_schedules.size() != 0) {
            // find greatest schedule
            Schedule target = next_schedules[0];
            for (auto &s : next_schedules) {
                if (s.hh > target.hh) {
                    target = s;
                } else if (s.hh == target.hh && s.mm > target.mm) {
                    target = s;
                }
            }

            //
            printf("led_display: run %02d:%02d task\n", target.hh, target.mm);

            // output to led with current time condition
            set_duty(target.leds);

        } else {
            printf(" no schedule found\n");
        }

        // display greatest schedule

        schedules.clear();
        schedules.shrink_to_fit();
        return;
    }
}

void set_duty(LEDLevel leds) {
    printf("led set duty red=%d, green=%d, blue=%d, white=%d, warmWhite=%d\n", leds.red, leds.green, leds.blue, leds.white, leds.warm_white);
    ledc_set_duty(LEDC_HS_MODE, LED_WHITE, (leds.red / 100) * LEDC_DUTY);
    ledc_set_duty(LEDC_HS_MODE, LED_WARM_WHITE, (leds.green / 100) * LEDC_DUTY);
    ledc_set_duty(LEDC_HS_MODE, LED_RED, (leds.blue / 100) * LEDC_DUTY);
    ledc_set_duty(LEDC_HS_MODE, LED_GREEN, (leds.white / 100) * LEDC_DUTY);
    ledc_set_duty(LEDC_HS_MODE, LED_BLUE, (leds.warm_white / 100) * LEDC_DUTY);
    ledc_set_duty(LEDC_HS_MODE, LED_ROYAL_BLUE, (leds.royal_blue / 100) * LEDC_DUTY);
    ledc_set_duty(LEDC_HS_MODE, LED_ULTRA_VIOLET, (leds.ultra_violet / 100) * LEDC_DUTY);
    // TODO: add violet color
    ledc_set_duty(LEDC_HS_MODE, LED_VIOLET, (leds.ultra_violet / 100) * LEDC_DUTY);

    ledc_update_duty(LEDC_HS_MODE, LED_WHITE);
    ledc_update_duty(LEDC_HS_MODE, LED_WARM_WHITE);
    ledc_update_duty(LEDC_HS_MODE, LED_RED);
    ledc_update_duty(LEDC_HS_MODE, LED_GREEN);
    ledc_update_duty(LEDC_HS_MODE, LED_BLUE);
    ledc_update_duty(LEDC_HS_MODE, LED_ROYAL_BLUE);
    ledc_update_duty(LEDC_HS_MODE, LED_ULTRA_VIOLET);
    ledc_update_duty(LEDC_HS_MODE, LED_VIOLET);
}