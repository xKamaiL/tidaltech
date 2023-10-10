#include "main.h"

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

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

char *BLE_NAME = "TIDAL TECH";
uint8_t ble_addr_type;
void ble_app_advertise(void);

// Write data to ESP32 defined as server
static int device_write(uint16_t conn_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg) {
    printf("Data from the client: %.*s\n", ctxt->om->om_len, ctxt->om->om_data);
    return 0;
}

// Read data from ESP32 defined as server
static int device_read(uint16_t con_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg) {
    os_mbuf_append(ctxt->om, "Data from the server", strlen("Data from the server"));
    return 0;
}

// BLE event handling
static int ble_gap_event(struct ble_gap_event *event, void *arg) {
    switch (event->type) {
        // Advertise if connected
        case BLE_GAP_EVENT_CONNECT:
            ESP_LOGI("GAP", "BLE GAP EVENT CONNECT %s", event->connect.status == 0 ? "OK!" : "FAILED!");
            if (event->connect.status != 0) {
                // retry again if failed
                ble_app_advertise();
            }
            break;
        // Advertise again after completion of the event
        case BLE_GAP_EVENT_ADV_COMPLETE:
            ESP_LOGI("GAP", "BLE GAP EVENT");
            ble_app_advertise();
            break;
        case BLE_GAP_EVENT_DISCONNECT:
            ESP_LOGI("GAP", "BLE GAP EVENT DISCONNECT");
            ble_app_advertise();
            break;
        default:
            break;
    }
    return 0;
}

// Define the BLE connection
void ble_app_advertise(void) {
    // GAP - device name definition
    struct ble_hs_adv_fields fields;
    const char *device_name;
    memset(&fields, 0, sizeof(fields));
    device_name = ble_svc_gap_device_name();  // Read the BLE device name
    // set uuid to 0x180F
    fields.uuids128 = BLE_UUID128_DECLARE(0x152CF9EE363711EE8077B08A6F34574D);
    fields.uuids128_is_complete = 1;
    fields.name = (uint8_t *)device_name;
    fields.name_len = strlen(device_name);
    fields.name_is_complete = 1;

    fields.mfg_data = (uint8_t *)device_name;
    fields.mfg_data_len = 0;
    if (ble_gap_adv_set_fields(&fields) != 0) {
        printf("Failed to set advertise fields\n");
        return;
    }

    // GAP - device connectivity definition
    struct ble_gap_adv_params adv_params;
    memset(&adv_params, 0, sizeof(adv_params));
    adv_params.conn_mode = BLE_GAP_CONN_MODE_UND;  // connectable or non-connectable
    adv_params.disc_mode = BLE_GAP_DISC_MODE_GEN;  // discoverable or non-discoverable
    int ret = ble_gap_adv_start(ble_addr_type, NULL, BLE_HS_FOREVER, &adv_params, ble_gap_event, NULL);
    if (ret != 0) {
        printf("Failed to start advertising\n");
        return;
    }
}

// The application
void ble_app_on_sync(void) {
    ble_hs_id_infer_auto(0, &ble_addr_type);  // Determines the best address type automatically
    ble_app_advertise();                      // Define the BLE connection
}

// The infinite task
void host_task(void *param) {
    nimble_port_run();
    nimble_port_freertos_deinit();
}

void app_main(void) {
    int rc;
    rc = nvs_flash_init();
    assert(rc == 0);

    rc = nimble_port_init();
    assert(rc == 0);
    rc = ble_svc_gap_device_name_set(BLE_NAME);
    assert(rc == 0);

    ble_svc_gap_init();   // Initialize the GAP (Generic Access Profile)
    ble_svc_gatt_init();  // Initialize the GATT (Generic Attribute Profile)
    rc = ble_gatts_count_cfg(gatt_svcs);
    assert(rc == 0);

    rc = ble_gatts_add_svcs(gatt_svcs);
    assert(rc == 0);

    ble_hs_cfg.sync_cb = ble_app_on_sync;  // Callback for BLE synchronization

    nimble_port_freertos_init(host_task);  // Initialize the NimBLE host task
}
