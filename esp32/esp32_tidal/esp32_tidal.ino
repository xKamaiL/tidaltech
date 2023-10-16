
#include <NimBLEDevice.h>

#define SERVICE_UUID "2840ef22-f2ba-46b7-a1d4-cd06ce7e65b9"
static NimBLEServer* pServer;

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks {
  void onRead(NimBLECharacteristic* pCharacteristic) {
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onRead(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
  };

  void onWrite(NimBLECharacteristic* pCharacteristic) {
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onWrite(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
  };
  /** Called before notification or indication is sent,
     *  the value can be changed here before sending if desired.
     */
  void onNotify(NimBLECharacteristic* pCharacteristic) {
    Serial.println("Sending notification to clients");
  };


  /** The status returned in status is defined in NimBLECharacteristic.h.
     *  The value returned in code is the NimBLE host return code.
     */
  void onStatus(NimBLECharacteristic* pCharacteristic, Status status, int code) {
    String str = ("Notification/Indication status code: ");
    str += status;
    str += ", return code: ";
    str += code;
    str += ", ";
    str += NimBLEUtils::returnCodeToString(code);
    Serial.println(str);
  };

  void onSubscribe(NimBLECharacteristic* pCharacteristic, ble_gap_conn_desc* desc, uint16_t subValue) {
    String str = "Client ID: ";
    str += desc->conn_handle;
    str += " Address: ";
    str += std::string(NimBLEAddress(desc->peer_ota_addr)).c_str();
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

    Serial.println(str);
  };
};

static CharacteristicCallbacks chrCallbacks;


static NimBLEUUID dataUuid(SERVICE_UUID);

class ServerCallbacks : public NimBLEServerCallbacks {
  void onConnect(NimBLEServer* pServer) {
    Serial.println("Client connected");
    Serial.println("Multi-connect support: start advertising");
    NimBLEDevice::startAdvertising();
  };
  /** Alternative onConnect() method to extract details of the connection.
     *  See: src/ble_gap.h for the details of the ble_gap_conn_desc struct.
     */
  void onConnect(NimBLEServer* pServer, ble_gap_conn_desc* desc) {
    Serial.print("Client address: ");
    Serial.println(NimBLEAddress(desc->peer_ota_addr).toString().c_str());
    /** We can use the connection handle here to ask for different connection parameters.
         *  Args: connection handle, min connection interval, max connection interval
         *  latency, supervision timeout.
         *  Units; Min/Max Intervals: 1.25 millisecond increments.
         *  Latency: number of intervals allowed to skip.
         *  Timeout: 10 millisecond increments, try for 5x interval time for best results.
         */
    pServer->updateConnParams(desc->conn_handle, 24, 48, 0, 60);
  };
  void onDisconnect(NimBLEServer* pServer) {
    Serial.println("Client disconnected - start advertising");
    NimBLEDevice::startAdvertising();
  };
  void onMTUChange(uint16_t MTU, ble_gap_conn_desc* desc) {
    Serial.printf("MTU updated: %u for connection ID: %u\n", MTU, desc->conn_handle);
  };
};

void setup() {
  Serial.begin(115200);
  Serial.println("Starting BLE work!");

  NimBLEDevice::init("TIDAL TECH LIGHING");
#ifdef ESP_PLATFORM
  NimBLEDevice::setPower(ESP_PWR_LVL_P9); /** +9db */
#else
  NimBLEDevice::setPower(9); /** +9db */
#endif
  pServer = NimBLEDevice::createServer();

  pServer->setCallbacks(new ServerCallbacks());

  NimBLEService* deviceInformationService = pServer->createService(NimBLEUUID("b9657ece-06cd-d4a1-b746-baf222ef4028"));
  NimBLEService* colorService = pServer->createService(NimBLEUUID("72b60562-580c-4946-b3b5-8bd8bf8d8c5b"));
  NimBLEService* rtcService = pServer->createService(NimBLEUUID("2f659cc6-7bdc-4c2a-966f-2411706b0b85"));

  NimBLECharacteristic* x1Characteristic = deviceInformationService->createCharacteristic("DEVICE NAME", NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE);
  x1Characteristic->setValue("Burger");
  x1Characteristic->setCallbacks(&chrCallbacks);

  NimBLECharacteristic* x2 = colorService->createCharacteristic("SET COLOR", NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE);
  x2->setValue("Burger");
  x2->setCallbacks(&chrCallbacks);


  NimBLECharacteristic* x3 = rtcService->createCharacteristic("TIME", NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE);
  x3->setValue("00/00/0000 23:59");
  x3->setCallbacks(&chrCallbacks);

  //
  deviceInformationService->start();
  colorService->start();
  rtcService->start();
  //

  NimBLEAdvertising* pAdvertising = NimBLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(deviceInformationService->getUUID());
  pAdvertising->addServiceUUID(colorService->getUUID());
  pAdvertising->addServiceUUID(rtcService->getUUID());

  pAdvertising->setScanResponse(true);
  pAdvertising->start();
  Serial.println("Advertising Started");
}

void loop() {
  /** Do your thing here, this just spams notifications to all connected clients */
  if (pServer->getConnectedCount()) {
  }
}


void updateValue() {
}