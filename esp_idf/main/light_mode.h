#ifndef LIGHT_MODE_H
#define LIGHT_MODE_H
#include "esp_err.h"

#define NAMESPACE "schedule"

#define LIGHT_MODE_SCHEDULE 0
#define LIGHT_MODE_MANUAL 1
typedef struct {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} StaticColor;

extern esp_err_t write_light_mode_to_nvs(int8_t mode);
extern esp_err_t read_light_mode_from_nvs(int8_t* mode);

extern esp_err_t write_static_color_to_nvs(StaticColor color);
extern esp_err_t read_static_color_from_nvs(StaticColor* color);

#endif  // LIGHT_MODE_H