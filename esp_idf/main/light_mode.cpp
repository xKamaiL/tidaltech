#include "light_mode.h"

#include "esp_err.h"
#include "nvs_flash.h"
#include "schedule.h"

esp_err_t write_light_mode_to_nvs(int8_t mode) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READWRITE, &handle);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_set_i8(handle, "mode", mode);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_commit(handle);
    if (err != ESP_OK) {
        return err;
    }
    nvs_close(handle);
    return ESP_OK;
}
esp_err_t read_light_mode_from_nvs(int8_t* mode) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READONLY, &handle);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return 0;
        }
        return err;
    }

    err = nvs_get_i8(handle, "mode", mode);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return 0;
        }
        return err;  // default mode
    }
    nvs_close(handle);
    return ESP_OK;
}

esp_err_t write_static_color_to_nvs(LEDLevel leds) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READWRITE, &handle);
    if (err != ESP_OK) {
        return err;
    }

    err = nvs_set_blob(handle, "leds", &leds, sizeof(LEDLevel));
    if (err != ESP_OK) {
        return err;
    }

    err = nvs_commit(handle);
    if (err != ESP_OK) {
        return err;
    }
    nvs_close(handle);
    return ESP_OK;
}

esp_err_t read_static_color_from_nvs(LEDLevel* leds) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READONLY, &handle);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return ESP_OK;
        }
        return err;
    }

    size_t size = sizeof(LEDLevel);
    err = nvs_get_blob(handle, "leds", leds, &size);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return ESP_OK;
        }
        return err;
    }

    nvs_close(handle);
    return ESP_OK;
}