#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "host/ble_hs.h"
#include "nimble/ble.h"
#include "proto/message.pb-c.h"

static int device_read(uint16_t con_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg);
static int device_write(uint16_t conn_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg);