#include "callback.h"

#include "NimBLEDevice.h"
#include "proto/message.pb-c.h"
#include "schedule.h"

void on_add_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    LightingScheduleRequest *req = lighting_schedule_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("addColorTimePoint: decode message failed\n");
        return;
    }
    printf("addColorTimePoint: %ld:%ld with sizes %u\n", req->hh, req->mm, pCharacteristic->getValue().length());

    unsigned short hh = req->hh;
    unsigned short mm = req->mm;

    LEDLevel leds;
    leds.white = req->white;
    leds.warm_white = req->warm_white;
    leds.red = req->red;
    leds.green = req->green;
    leds.blue = req->blue;
    leds.royal_blue = req->royal_blue;
    leds.ultra_violet = req->ultra_violet;
    lighting_schedule_request__free_unpacked(req, NULL);

    std::vector<Schedule> schedules;
    esp_err_t err = read_schedule_from_nvs(schedules);
    if (err != ESP_OK) {
        printf("addColorTimePoint: read schedule failed\n");
        return;
    }
    upsert_schedules(schedules, {true, hh, mm, leds});

    err = write_schedule_to_nvs(schedules);
    schedules.clear();
    schedules.shrink_to_fit();
    if (err != ESP_OK) {
        printf("addColorTimePoint: write schedule failed\n");
        return;
    }
    return;
}

void on_available_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    ListTimePointRequest *req = list_time_point_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("onAvailableColorTimePoints: decode message failed\n");
        return;
    }

    std::vector<Schedule> schedules;
    esp_err_t err = read_schedule_from_nvs(schedules);
    if (err != ESP_OK) {
        list_time_point_request__free_unpacked(req, NULL);
        printf("onAvailableColorTimePoints: read schedule failed\n");
        return;
    }

    filter_schedules(schedules, [&](const Schedule &s) {
        for (size_t i = 0; i < req->n_times; ++i) {
            unsigned short hh = req->times[i]->hh;
            unsigned short mm = req->times[i]->mm;
            if (s.hh == hh && s.mm == mm) {
                return true;
            }
        }
        return false;
    });

    list_time_point_request__free_unpacked(req, NULL);

    err = write_schedule_to_nvs(schedules);
    schedules.clear();
    schedules.shrink_to_fit();
    if (err != ESP_OK) {
        printf("onAvailableColorTimePoints: write schedule failed\n");
        return;
    }
    return;
}

void on_set_color_mode(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    SetColorModeRequest *req = set_color_mode_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("onSetColorMode: decode message failed\n");
        return;
    }

    Mode mode = req->mode;
    set_color_mode_request__free_unpacked(req, NULL);

    printf("onSetColorMode: %d\n", mode);

    // TODO: change color mode ?
}

void on_set_ambient(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
    SetAmbientRequest *req = set_ambient_request__unpack(NULL, pCharacteristic->getValue().length(), (uint8_t *)pCharacteristic->getValue().c_str());
    if (req == NULL) {
        printf("onSetAmbient: decode message failed\n");
        return;
    }
    int r = req->r;
    int g = req->g;
    int b = req->b;
    set_ambient_request__free_unpacked(req, NULL);

    // TODO: change ambient R,G,B color
    // but do not change the current color mode
    printf("onSetAmbient: %d,%d,%d\n", r, g, b);
}
