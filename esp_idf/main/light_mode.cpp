#include "light_mode.h"

#include "esp_err.h"
#include "nvs_flash.h"

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

esp_err_t write_static_color_to_nvs(StaticColor color) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READWRITE, &handle);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_set_u8(handle, "r", color.r);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_set_u8(handle, "g", color.g);
    if (err != ESP_OK) {
        return err;
    }
    err = nvs_set_u8(handle, "b", color.b);
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

esp_err_t read_static_color_from_nvs(StaticColor* color) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READONLY, &handle);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return 0;
        }
        return err;
    }

    err = nvs_get_u8(handle, "r", &color->r);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return 0;
        }
        return err;  // default mode
    }
    err = nvs_get_u8(handle, "g", &color->g);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return 0;
        }
        return err;  // default mode
    }
    err = nvs_get_u8(handle, "b", &color->b);
    if (err != ESP_OK) {
        if (err == ESP_ERR_NVS_NOT_FOUND) {
            return 0;
        }
        return err;  // default mode
    }
    nvs_close(handle);
    return ESP_OK;
}