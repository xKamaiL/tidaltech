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
        .uuid = BLE_UUID16_DECLARE(0x180),
        .characteristics = (struct ble_gatt_chr_def[]){
            {
                .uuid = BLE_UUID16_DECLARE(0xFEF4),
                .flags = BLE_GATT_CHR_F_READ,
                .access_cb = device_read,
            },
            {
                .uuid = BLE_UUID16_DECLARE(0xDEAD),
                .flags = BLE_GATT_CHR_F_WRITE_NO_RSP,
                .access_cb = device_write,
            },
            {0},
        },
    },
    {0},  // must be terminated with an entry of all zeroes
};