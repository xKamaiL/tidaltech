#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "host/ble_hs.h"
#include "nimble/ble.h"
#include "proto/message.pb-c.h"

static int device_read(uint16_t con_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg);
static int device_write(uint16_t conn_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg);

// Array of pointers to other service definitions
// UUID - Universal Unique Identifier
static const struct ble_gatt_svc_def gatt_svcs[] = {
    {
        .type = BLE_GATT_SVC_TYPE_PRIMARY,
        // 2840ef22-f2ba-46b7-a1d4-cd06ce7e65b9
        .uuid = BLE_UUID128_DECLARE(0x28, 0x40, 0xEF, 0x22, 0xF2, 0xBA, 0x46, 0xB7, 0xA1, 0xD4, 0xCD, 0x06, 0xCE, 0x7E, 0x65, 0xB9),
        .characteristics = (struct ble_gatt_chr_def[]){
            // {
            //     .uuid = BLE_UUID16_DECLARE(0xFEF4),
            //     .flags = BLE_GATT_CHR_F_READ,
            //     .access_cb = device_read,
            // },
            // {
            //     .uuid = BLE_UUID16_DECLARE(0xDEAD),
            //     .flags = BLE_GATT_CHR_F_WRITE_NO_RSP,
            //     .access_cb = device_write,
            // },
            {0},
        },
    },
    {
        .type = BLE_GATT_SVC_TYPE_PRIMARY,
        // 72b60562-580c-4946-b3b5-8bd8bf8d8c5b
        .uuid = BLE_UUID128_DECLARE(0x72, 0xB6, 0x05, 0x62, 0x58, 0x0C, 0x49, 0x46, 0xB3, 0xB5, 0x8B, 0xD8, 0xBF, 0x8D, 0x8C, 0x5B),
        .characteristics = (struct ble_gatt_chr_def[]){
            {0},
        },
    },
    {
        .type = BLE_GATT_SVC_TYPE_PRIMARY,
        // 2f659cc6-7bdc-4c2a-966f-2411706b0b85
        .uuid = BLE_UUID128_DECLARE(0x2f, 0x65, 0x9c, 0xc6, 0x7b, 0xdc, 0x4c, 0x2a, 0x96, 0x6f, 0x24, 0x11, 0x70, 0x6b, 0x0b, 0x85),
        .characteristics = (struct ble_gatt_chr_def[]){
            {0},
        },
    },
    {0},  // must be terminated with an entry of all zeroes
};
