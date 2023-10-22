#ifndef CALLBACK_H
#define CALLBACK_H

#include "NimBLEDevice.h"

void on_add_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);
void on_set_color_mode(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);
void on_set_ambient(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);
void on_available_color_time_points(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo);

#endif
