#include <inttypes.h>
#include <stdio.h>

#include <algorithm>
#include <string>
#include <vector>

#include "NimBLEDevice.h"
#include "definations.h"
#include "driver/rtc_io.h"
#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include "freertos/task.h"
#include "freertos/timers.h"
#include "nvs.h"
#include "nvs_flash.h"
#include "proto/message.pb-c.h"
#include "sdkconfig.h"
#define STORAGE_SCHEDULE "store"
#include "schedule.h"

/* Handler class for server events */
class ServerCallbacks : public NimBLEServerCallbacks {
    void onConnect(NimBLEServer *pServer, NimBLEConnInfo &connInfo) {
        printf("Client connected:: %s\n", connInfo.getAddress().toString().c_str());
    };

    void onDisconnect(NimBLEServer *pServer, NimBLEConnInfo &connInfo, int reason) {
        printf("Client disconnected\n");
    };
};

void on_add_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);
void on_set_color_mode(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);
void on_set_ambient(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);
void on_available_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks {
    void onRead(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_GET_COLOR_MODE)) {
            return;
        }
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_GET_CURRENT_TIME)) {
            return;
        }
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_GET_COLOR_MODE)) {
            pCharacteristic->setValue(0);
            return;
        }
    };

    void onWrite(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo) {
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_ADD_COLOR_TIME_POINT)) {
            on_add_color_time_points(pCharacteristic, connInfo);
            return;
        }
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_SET_COLOR_MODE)) {
            on_set_color_mode(pCharacteristic, connInfo);
            return;
        }
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_SET_AMBIENT)) {
            on_set_ambient(pCharacteristic, connInfo);
            return;
        }
        if (pCharacteristic->getUUID().equals(CHARACTERISTIC_UUID_LIST_COLOR_TIME_POINT)) {
            on_available_color_time_points(pCharacteristic, connInfo);
            return;
        }
    };

    void onNotify(NimBLECharacteristic *pCharacteristic){};

    void onStatus(NimBLECharacteristic *pCharacteristic, int code) {
        std::string str = ("Notification/Indication status code: ");
        str += ", return code: ";
        str += code;
        str += ", ";
        str += NimBLEUtils::returnCodeToString(code);
        printf(str.c_str());
    };

    void onSubscribe(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo, uint16_t subValue) {
        std::string str = "Client ID: ";
        str += " Address: ";
        str += std::string(connInfo.getAddress()).c_str();
        if (subValue == 0) {
            str += " Unsubscribed to ";
        } else if (subValue == 1) {
            str += " Subscribed to notfications for ";
        } else if (subValue == 2) {
            str += " Subscribed to indications for ";
        } else if (subValue == 3) {
            str += " Subscribed to notifications and indications for ";
        }
        str += std::string(pCharacteristic->getUUID()).c_str();
        printf(str.c_str());
    };
};
static CharacteristicCallbacks chrCallbacks;

extern "C" {
void app_main(void);
}

void app_main(void) {
    esp_err_t err = nvs_flash_init();
    if (err == ESP_ERR_NVS_NO_FREE_PAGES || err == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        // NVS partition was truncated and needs to be erased
        // Retry nvs_flash_init
        ESP_ERROR_CHECK(nvs_flash_erase());
        err = nvs_flash_init();
    }
    ESP_ERROR_CHECK(err);

    NimBLEDevice::init("TIDAL TECH LIGHTING");
    // NimBLEDevice::setPower(ESP_PWR_LVL_P9); /** +9db */

    NimBLEServer *srv = NimBLEDevice::createServer();
    srv->setCallbacks(new ServerCallbacks);

    NimBLEService *deviceInformationService = srv->createService(DEVICE_INFORMATION_SERVICE_UUID);

    NimBLECharacteristic *deviceNameCharacteristic = deviceInformationService->createCharacteristic(
        CHARACTERISTIC_UUID_DEVICE_ID, NIMBLE_PROPERTY::READ);
    deviceNameCharacteristic->setValue(NimBLEUUID(""));

    deviceNameCharacteristic->setCallbacks(&chrCallbacks);

    NimBLECharacteristic *deviceIdCharacteristic = deviceInformationService->createCharacteristic(
        CHARACTERISTIC_UUID_DEVICE_NAME, NIMBLE_PROPERTY::READ);
    deviceIdCharacteristic->setValue("TIDAL TECH LIGHTING");
    deviceIdCharacteristic->setCallbacks(&chrCallbacks);

    NimBLEService *colorService = srv->createService(COLOR_SERVICE_UUID);
    NimBLECharacteristic *getCurrentMode = colorService->createCharacteristic(CHARACTERISTIC_UUID_GET_COLOR_MODE, NIMBLE_PROPERTY::READ);
    getCurrentMode->setCallbacks(&chrCallbacks);
    NimBLECharacteristic *setColorMode = colorService->createCharacteristic(CHARACTERISTIC_UUID_SET_COLOR_MODE, NIMBLE_PROPERTY::WRITE_NR);
    setColorMode->setCallbacks(&chrCallbacks);

    NimBLECharacteristic *addColorTimePointCh = colorService->createCharacteristic(CHARACTERISTIC_UUID_ADD_COLOR_TIME_POINT, NIMBLE_PROPERTY::WRITE_NR);
    addColorTimePointCh->setCallbacks(&chrCallbacks);

    // get current mode
    // add time points
    // get time point list
    // set mode (schedule, manual)

    NimBLEService *rtcService = srv->createService(RTC_SERVICE_UUID);

    NimBLECharacteristic *getCurrentTime = rtcService->createCharacteristic(CHARACTERISTIC_UUID_GET_CURRENT_TIME, NIMBLE_PROPERTY::READ);
    NimBLECharacteristic *setCurrentTime = rtcService->createCharacteristic(CHARACTERISTIC_UUID_SET_CURRENT_TIME, NIMBLE_PROPERTY::WRITE_NR);

    getCurrentTime->setCallbacks(&chrCallbacks);
    setCurrentTime->setCallbacks(&chrCallbacks);

    //

    deviceInformationService->start();
    colorService->start();
    rtcService->start();

    NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->setName("TIDAL TECH LIGHTING");
    pAdvertising->addServiceUUID(deviceInformationService->getUUID());
    pAdvertising->addServiceUUID(colorService->getUUID());
    pAdvertising->addServiceUUID(rtcService->getUUID());
    pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
    pAdvertising->setMinPreferred(0x12);
    pAdvertising->setScanResponse(true);

    BLEDevice::startAdvertising();

    printf("Characteristic defined! Now you can read it in your phone!\n");

    // FreeRTOS task
}

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
    list_time_point_request__free_unpacked(req, NULL);

    std::vector<Schedule> schedules;
    esp_err_t err = read_schedule_from_nvs(schedules);
    if (err != ESP_OK) {
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

    err = write_schedule_to_nvs(schedules);
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

Mode *read_color_mode_from_nvs() {
    nvs_handle_t handle2;
    esp_err_t err;

    err = nvs_open(STORAGE_SCHEDULE, NVS_READONLY, &handle2);
    if (err != ESP_OK)
        return NULL;

    return 0;
}
