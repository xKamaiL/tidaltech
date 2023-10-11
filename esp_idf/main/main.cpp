#include <inttypes.h>
#include <stdio.h>

#include "NimBLEDevice.h"
#include "definations.h"
#include "esp_chip_info.h"
#include "esp_flash.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
// #include "message.pb-c.h"
#include "nvs_flash.h"
#include "sdkconfig.h"

void initService(NimBLEServer* srv) {
    NimBLEService* deviceInformationService = srv->createService(DEVICE_INFORMATION_SERVICE_UUID);

    NimBLECharacteristic* deviceNameCharacteristic = deviceInformationService->createCharacteristic(
        CHARACTERISTIC_UUID_DEVICE_ID, NIMBLE_PROPERTY::READ);
    NimBLECharacteristic* deviceIdCharacteristic = deviceInformationService->createCharacteristic(
        CHARACTERISTIC_UUID_DEVICE_NAME, NIMBLE_PROPERTY::READ);

    NimBLEService* colorService = srv->createService(COLOR_SERVICE_UUID);

    NimBLECharacteristic* getCurrentMode = colorService->createCharacteristic(CHARACTERISTIC_UUID_GET_COLOR_MODE, NIMBLE_PROPERTY::READ);
    NimBLECharacteristic* setColorMode = colorService->createCharacteristic(CHARACTERISTIC_UUID_SET_COLOR_MODE, NIMBLE_PROPERTY::WRITE_NR);

    // get current mode
    // add time points
    // get time point list
    // set mode (schedule, manual)

    NimBLEService* rtcService = srv->createService(RTC_SERVICE_UUID);

    NimBLECharacteristic* getCurrentTime = rtcService->createCharacteristic(CHARACTERISTIC_UUID_GET_CURRENT_TIME, NIMBLE_PROPERTY::READ);
    NimBLECharacteristic* setCurrentTime = rtcService->createCharacteristic(CHARACTERISTIC_UUID_SET_CURRENT_TIME, NIMBLE_PROPERTY::WRITE_NR);

    //

    deviceInformationService->start();
    colorService->start();
    rtcService->start();

    NimBLEAdvertising* pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(deviceInformationService->getUUID());
    pAdvertising->addServiceUUID(colorService->getUUID());
    pAdvertising->addServiceUUID(rtcService->getUUID());

    pAdvertising->setScanResponse(true);
    return;
}
extern "C" {
void app_main(void);
}
void app_main(void) {
    NimBLEDevice::init("NimBLE");

    NimBLEServer* server = NimBLEDevice::createServer();

    initService(server);

    server->start();
    printf("Start server!\n");

    while (1) {
        ESP_LOGI("DO", "WHILE LOOP");
    }
}
