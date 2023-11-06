#ifndef LED_H
#define LED_H

#include "driver/ledc.h"
#include "time.h"

#define LEDC_HS_TIMER LEDC_TIMER_0
#define LEDC_HS_MODE LEDC_LOW_SPEED_MODE
#define LEDC_DUTY_RES LEDC_TIMER_12_BIT  // Set duty resolution to 13 bits
#define LEDC_DUTY (4096)
#define LEDC_FREQUENCY (500)
#define LEDC_HS_CH0_GPIO (12)
#define LEDC_HS_CH1_GPIO (14)
#define LEDC_HS_CH2_GPIO (25)
#define LEDC_HS_CH3_GPIO (26)
#define LEDC_HS_CH4_GPIO (27)
#define LEDC_HS_CH5_GPIO (32)
#define LEDC_HS_CH6_GPIO (33)
#define LEDC_HS_CH7_GPIO (15)

// -- color led channel mapping --
#define LED_WHITE LEDC_CHANNEL_0
#define LED_WARM_WHITE LEDC_CHANNEL_1
#define LED_RED LEDC_CHANNEL_5
#define LED_GREEN LEDC_CHANNEL_3  // Blue
#define LED_BLUE LEDC_CHANNEL_6   // UV
#define LED_ROYAL_BLUE LEDC_CHANNEL_4
#define LED_ULTRA_VIOLET LEDC_CHANNEL_7
#define LED_VIOLET LEDC_CHANNEL_2

void initialize_led();
// led_display displays the current configuration of the LED
void led_display(tm now);

#endif  // LED_H