#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

#include "NimBLEDevice.h"
#include "driver/gpio.h"
#include "esp_event.h"
#include "esp_flash.h"
#include "esp_log.h"
#include "esp_nimble_hci.h"
#include "esp_system.h"
#include "freertos/FreeRTOS.h"
#include "freertos/event_groups.h"
#include "freertos/task.h"
#include "host/ble_hs.h"
#include "nimble/ble.h"
#include "nimble/nimble_port.h"
#include "nimble/nimble_port_freertos.h"
#include "nvs_flash.h"
#include "sdkconfig.h"
#include "services/gap/ble_svc_gap.h"
#include "services/gatt/ble_svc_gatt.h"

// import protoc files message
#include "proto/message.pb-c.h"

void app_main(void) {
    int rc;
    rc = nvs_flash_init();
    assert(rc == 0);

    NimBLEDevice::init("NimBLE");

    NimBLEServer *pServer = NimBLEDevice::createServer();
    NimBLEService *pService = pServer->createService("ABCD");
}
