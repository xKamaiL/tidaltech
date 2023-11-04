#ifndef LIGHT_MODE_H
#define LIGHT_MODE_H
#include "esp_err.h"

#define NAMESPACE "schedule"

extern esp_err_t write_light_mode_to_nvs(int8_t mode);
extern esp_err_t read_light_mode_from_nvs(int8_t* mode);

#endif  // LIGHT_MODE_H