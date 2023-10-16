#include <inttypes.h>
#include <stdio.h>

#include <string>

#include "NimBLEDevice.h"
#include "definations.h"
#include "esp_log.h"
#include "esp_sleep.h"
#include "message.pb-c.h"
#include "sdkconfig.h"

/* Handler class for server events */
class ServerCallbacks : public NimBLEServerCallbacks {
    void onConnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo) {
        printf("Client connected:: %s\n", connInfo.getAddress().toString().c_str());
    };

    void onDisconnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo, int reason) {
        printf("Client disconnected\n");
    };
};

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks {
    void onRead(NimBLECharacteristic* pCharacteristic, NimBLEConnInfo& connInfo) {
        printf(pCharacteristic->getUUID().toString().c_str());
        printf(": onRead(), value: ");
        printf(pCharacteristic->getValue().c_str());
    };

    void onWrite(NimBLECharacteristic* pCharacteristic, NimBLEConnInfo& connInfo) {
        printf(pCharacteristic->getUUID().toString().c_str());
        printf(": onWrite(), value: ");
        printf(pCharacteristic->getValue().c_str());
    };
    /** Called before notification or indication is sent,
     *  the value can be changed here before sending if desired.
     */
    void onNotify(NimBLECharacteristic* pCharacteristic) {
        printf("Sending notification to clients");
    };

    /** The status returned in status is defined in NimBLECharacteristic.h.
     *  The value returned in code is the NimBLE host return code.
     */
    void onStatus(NimBLECharacteristic* pCharacteristic, int code) {
        std::string str = ("Notification/Indication status code: ");
        str += ", return code: ";
        str += code;
        str += ", ";
        str += NimBLEUtils::returnCodeToString(code);
        printf(str.c_str());
    };

    void onSubscribe(NimBLECharacteristic* pCharacteristic, NimBLEConnInfo& connInfo, uint16_t subValue) {
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
    NimBLEDevice::init("TIDAL TECH LIGHTING");
    // NimBLEDevice::setPower(ESP_PWR_LVL_P9); /** +9db */

    NimBLEServer* srv = NimBLEDevice::createServer();
    srv->setCallbacks(new ServerCallbacks);

    NimBLEService* deviceInformationService = srv->createService(DEVICE_INFORMATION_SERVICE_UUID);

    NimBLECharacteristic* deviceNameCharacteristic = deviceInformationService->createCharacteristic(
        CHARACTERISTIC_UUID_DEVICE_ID, NIMBLE_PROPERTY::READ);
    deviceNameCharacteristic->setValue(NimBLEUUID(""));

    deviceNameCharacteristic->setCallbacks(&chrCallbacks);

    NimBLECharacteristic* deviceIdCharacteristic = deviceInformationService->createCharacteristic(
        CHARACTERISTIC_UUID_DEVICE_NAME, NIMBLE_PROPERTY::READ);
    deviceIdCharacteristic->setValue("TIDAL TECH LIGHTING");
    deviceIdCharacteristic->setCallbacks(&chrCallbacks);

    NimBLEService* colorService = srv->createService(COLOR_SERVICE_UUID);
    size_t x = sizeof(LightingScheduleRequest);
    NimBLECharacteristic* getCurrentMode = colorService->createCharacteristic(CHARACTERISTIC_UUID_GET_COLOR_MODE, NIMBLE_PROPERTY::READ);
    getCurrentMode->setValue("0");
    getCurrentMode->setCallbacks(&chrCallbacks);
    NimBLECharacteristic* setColorMode = colorService->createCharacteristic(CHARACTERISTIC_UUID_SET_COLOR_MODE, NIMBLE_PROPERTY::WRITE_NR);
    setColorMode->setValue("0");
    setColorMode->setCallbacks(&chrCallbacks);

    // get current mode
    // add time points
    // get time point list
    // set mode (schedule, manual)

    NimBLEService* rtcService = srv->createService(RTC_SERVICE_UUID);

    NimBLECharacteristic* getCurrentTime = rtcService->createCharacteristic(CHARACTERISTIC_UUID_GET_CURRENT_TIME, NIMBLE_PROPERTY::READ);
    NimBLECharacteristic* setCurrentTime = rtcService->createCharacteristic(CHARACTERISTIC_UUID_SET_CURRENT_TIME, NIMBLE_PROPERTY::WRITE_NR);

    getCurrentTime->setCallbacks(&chrCallbacks);
    setCurrentTime->setCallbacks(&chrCallbacks);

    //

    deviceInformationService->start();
    colorService->start();
    rtcService->start();

    NimBLEAdvertising* pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(deviceInformationService->getUUID());
    pAdvertising->addServiceUUID(colorService->getUUID());
    pAdvertising->addServiceUUID(rtcService->getUUID());
    pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
    pAdvertising->setMinPreferred(0x12);
    pAdvertising->setScanResponse(true);

    BLEDevice::startAdvertising();

    printf("Characteristic defined! Now you can read it in your phone!\n");
}
