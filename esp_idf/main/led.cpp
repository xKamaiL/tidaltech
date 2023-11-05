
#include "led.h"

#include "light_mode.h"
#include "schedule.h"

static int gpio_pins[] = {
    LEDC_HS_CH0_GPIO,  //
    LEDC_HS_CH1_GPIO,  //
    LEDC_HS_CH2_GPIO,  //
    LEDC_HS_CH3_GPIO,  //
    LEDC_HS_CH4_GPIO,  //
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

void display() {
}
