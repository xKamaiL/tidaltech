/* Generated by the protocol buffer compiler.  DO NOT EDIT! */
/* Generated from: proto/message.proto */

#ifndef PROTOBUF_C_proto_2fmessage_2eproto__INCLUDED
#define PROTOBUF_C_proto_2fmessage_2eproto__INCLUDED

#include <protobuf-c/protobuf-c.h>

PROTOBUF_C__BEGIN_DECLS

#if PROTOBUF_C_VERSION_NUMBER < 1003000
# error This file was generated by a newer version of protoc-c which is incompatible with your libprotobuf-c headers. Please update your headers.
#elif 1004001 < PROTOBUF_C_MIN_COMPILER_VERSION
# error This file was generated by an older version of protoc-c which is incompatible with your libprotobuf-c headers. Please regenerate this file with a newer version of protoc-c.
#endif


typedef struct DeviceInformationRequest DeviceInformationRequest;
typedef struct DeviceInformationResponse DeviceInformationResponse;
typedef struct SetColorModeRequest SetColorModeRequest;
typedef struct SetStaticColorRequest SetStaticColorRequest;
typedef struct RTCRequest RTCRequest;
typedef struct ListTimePointRequest ListTimePointRequest;
typedef struct ListTimePointRequest__Time ListTimePointRequest__Time;
typedef struct LightingScheduleRequest LightingScheduleRequest;
typedef struct SetSceneRequest SetSceneRequest;
typedef struct GetSceneResponse GetSceneResponse;
typedef struct Effect Effect;
typedef struct UpgradeFirmwareRequest UpgradeFirmwareRequest;
typedef struct UpgradeFirmwareResponse UpgradeFirmwareResponse;
typedef struct TimeStamp TimeStamp;


/* --- enums --- */

typedef enum _Scene {
  SCENE__SCENE_UNSPECIFIED = 0
    PROTOBUF_C__FORCE_ENUM_TO_BE_INT_SIZE(SCENE)
} Scene;
typedef enum _CommandCode {
  COMMAND_CODE__COMMAND_CODE_UNSPECIFIED = 0,
  COMMAND_CODE__COMMAND_CODE_GET_PROPERTIES = 1,
  /*
   * prepend
   */
  COMMAND_CODE__COMMAND_CODE_SET_LIGHTING = 5,
  COMMAND_CODE__COMMAND_CODE_UPGRADE_FIRMWARE = 6
    PROTOBUF_C__FORCE_ENUM_TO_BE_INT_SIZE(COMMAND_CODE)
} CommandCode;
/*
 * Mode specifies the mode of the lighting
 */
typedef enum _Mode {
  MODE__MODE_UNSPECIFIED = 0,
  /*
   * Manual mode
   * show static lighting
   */
  MODE__MODE_MANUAL = 1,
  /*
   * Schedule mode
   * show lighting based on schedule time configured
   */
  MODE__MODE_SCHEDULE = 2
    PROTOBUF_C__FORCE_ENUM_TO_BE_INT_SIZE(MODE)
} Mode;

/* --- messages --- */

struct  DeviceInformationRequest
{
  ProtobufCMessage base;
};
#define DEVICE_INFORMATION_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&device_information_request__descriptor) \
 }


struct  DeviceInformationResponse
{
  ProtobufCMessage base;
  Mode mode;
  uint32_t current_timestamps;
  char *name;
  char *id;
  char *version;
};
#define DEVICE_INFORMATION_RESPONSE__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&device_information_response__descriptor) \
, MODE__MODE_UNSPECIFIED, 0, (char *)protobuf_c_empty_string, (char *)protobuf_c_empty_string, (char *)protobuf_c_empty_string }


struct  SetColorModeRequest
{
  ProtobufCMessage base;
  Mode mode;
};
#define SET_COLOR_MODE_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&set_color_mode_request__descriptor) \
, MODE__MODE_UNSPECIFIED }


struct  SetStaticColorRequest
{
  ProtobufCMessage base;
  uint32_t white;
  uint32_t warm_white;
  uint32_t red;
  uint32_t green;
  uint32_t blue;
  uint32_t royal_blue;
  uint32_t ultra_violet;
};
#define SET_STATIC_COLOR_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&set_static_color_request__descriptor) \
, 0, 0, 0, 0, 0, 0, 0 }


struct  RTCRequest
{
  ProtobufCMessage base;
  uint32_t timestamp;
};
#define RTCREQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&rtcrequest__descriptor) \
, 0 }


struct  ListTimePointRequest__Time
{
  ProtobufCMessage base;
  uint32_t hh;
  uint32_t mm;
};
#define LIST_TIME_POINT_REQUEST__TIME__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&list_time_point_request__time__descriptor) \
, 0, 0 }


struct  ListTimePointRequest
{
  ProtobufCMessage base;
  size_t n_times;
  ListTimePointRequest__Time **times;
};
#define LIST_TIME_POINT_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&list_time_point_request__descriptor) \
, 0,NULL }


/*
 * LightingScheduleRequest is the data that will be sent
 * to the device
 * which is sent one by one (time point) to the device
 */
struct  LightingScheduleRequest
{
  ProtobufCMessage base;
  uint32_t hh;
  uint32_t mm;
  uint32_t white;
  uint32_t warm_white;
  uint32_t red;
  uint32_t green;
  uint32_t blue;
  uint32_t royal_blue;
  uint32_t ultra_violet;
};
#define LIGHTING_SCHEDULE_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&lighting_schedule_request__descriptor) \
, 0, 0, 0, 0, 0, 0, 0, 0, 0 }


struct  SetSceneRequest
{
  ProtobufCMessage base;
  Scene scene;
};
#define SET_SCENE_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&set_scene_request__descriptor) \
, SCENE__SCENE_UNSPECIFIED }


struct  GetSceneResponse
{
  ProtobufCMessage base;
  Scene scene;
};
#define GET_SCENE_RESPONSE__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&get_scene_response__descriptor) \
, SCENE__SCENE_UNSPECIFIED }


/*
 * Effect store a list of TimeStamp
 * and how long the effect should last
 */
struct  Effect
{
  ProtobufCMessage base;
  uint32_t duration;
  size_t n_timestamps;
  TimeStamp **timestamps;
};
#define EFFECT__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&effect__descriptor) \
, 0, 0,NULL }


struct  UpgradeFirmwareRequest
{
  ProtobufCMessage base;
};
#define UPGRADE_FIRMWARE_REQUEST__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&upgrade_firmware_request__descriptor) \
 }


struct  UpgradeFirmwareResponse
{
  ProtobufCMessage base;
  protobuf_c_boolean is_latest_version;
  char *current_version;
};
#define UPGRADE_FIRMWARE_RESPONSE__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&upgrade_firmware_response__descriptor) \
, 0, (char *)protobuf_c_empty_string }


struct  TimeStamp
{
  ProtobufCMessage base;
  uint32_t seconds;
  uint32_t white;
  uint32_t warm_white;
  uint32_t red;
  uint32_t green;
  uint32_t blue;
  uint32_t royal_blue;
  uint32_t ultra_violet;
};
#define TIME_STAMP__INIT \
 { PROTOBUF_C_MESSAGE_INIT (&time_stamp__descriptor) \
, 0, 0, 0, 0, 0, 0, 0, 0 }


/* DeviceInformationRequest methods */
void   device_information_request__init
                     (DeviceInformationRequest         *message);
size_t device_information_request__get_packed_size
                     (const DeviceInformationRequest   *message);
size_t device_information_request__pack
                     (const DeviceInformationRequest   *message,
                      uint8_t             *out);
size_t device_information_request__pack_to_buffer
                     (const DeviceInformationRequest   *message,
                      ProtobufCBuffer     *buffer);
DeviceInformationRequest *
       device_information_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   device_information_request__free_unpacked
                     (DeviceInformationRequest *message,
                      ProtobufCAllocator *allocator);
/* DeviceInformationResponse methods */
void   device_information_response__init
                     (DeviceInformationResponse         *message);
size_t device_information_response__get_packed_size
                     (const DeviceInformationResponse   *message);
size_t device_information_response__pack
                     (const DeviceInformationResponse   *message,
                      uint8_t             *out);
size_t device_information_response__pack_to_buffer
                     (const DeviceInformationResponse   *message,
                      ProtobufCBuffer     *buffer);
DeviceInformationResponse *
       device_information_response__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   device_information_response__free_unpacked
                     (DeviceInformationResponse *message,
                      ProtobufCAllocator *allocator);
/* SetColorModeRequest methods */
void   set_color_mode_request__init
                     (SetColorModeRequest         *message);
size_t set_color_mode_request__get_packed_size
                     (const SetColorModeRequest   *message);
size_t set_color_mode_request__pack
                     (const SetColorModeRequest   *message,
                      uint8_t             *out);
size_t set_color_mode_request__pack_to_buffer
                     (const SetColorModeRequest   *message,
                      ProtobufCBuffer     *buffer);
SetColorModeRequest *
       set_color_mode_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   set_color_mode_request__free_unpacked
                     (SetColorModeRequest *message,
                      ProtobufCAllocator *allocator);
/* SetStaticColorRequest methods */
void   set_static_color_request__init
                     (SetStaticColorRequest         *message);
size_t set_static_color_request__get_packed_size
                     (const SetStaticColorRequest   *message);
size_t set_static_color_request__pack
                     (const SetStaticColorRequest   *message,
                      uint8_t             *out);
size_t set_static_color_request__pack_to_buffer
                     (const SetStaticColorRequest   *message,
                      ProtobufCBuffer     *buffer);
SetStaticColorRequest *
       set_static_color_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   set_static_color_request__free_unpacked
                     (SetStaticColorRequest *message,
                      ProtobufCAllocator *allocator);
/* RTCRequest methods */
void   rtcrequest__init
                     (RTCRequest         *message);
size_t rtcrequest__get_packed_size
                     (const RTCRequest   *message);
size_t rtcrequest__pack
                     (const RTCRequest   *message,
                      uint8_t             *out);
size_t rtcrequest__pack_to_buffer
                     (const RTCRequest   *message,
                      ProtobufCBuffer     *buffer);
RTCRequest *
       rtcrequest__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   rtcrequest__free_unpacked
                     (RTCRequest *message,
                      ProtobufCAllocator *allocator);
/* ListTimePointRequest__Time methods */
void   list_time_point_request__time__init
                     (ListTimePointRequest__Time         *message);
/* ListTimePointRequest methods */
void   list_time_point_request__init
                     (ListTimePointRequest         *message);
size_t list_time_point_request__get_packed_size
                     (const ListTimePointRequest   *message);
size_t list_time_point_request__pack
                     (const ListTimePointRequest   *message,
                      uint8_t             *out);
size_t list_time_point_request__pack_to_buffer
                     (const ListTimePointRequest   *message,
                      ProtobufCBuffer     *buffer);
ListTimePointRequest *
       list_time_point_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   list_time_point_request__free_unpacked
                     (ListTimePointRequest *message,
                      ProtobufCAllocator *allocator);
/* LightingScheduleRequest methods */
void   lighting_schedule_request__init
                     (LightingScheduleRequest         *message);
size_t lighting_schedule_request__get_packed_size
                     (const LightingScheduleRequest   *message);
size_t lighting_schedule_request__pack
                     (const LightingScheduleRequest   *message,
                      uint8_t             *out);
size_t lighting_schedule_request__pack_to_buffer
                     (const LightingScheduleRequest   *message,
                      ProtobufCBuffer     *buffer);
LightingScheduleRequest *
       lighting_schedule_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   lighting_schedule_request__free_unpacked
                     (LightingScheduleRequest *message,
                      ProtobufCAllocator *allocator);
/* SetSceneRequest methods */
void   set_scene_request__init
                     (SetSceneRequest         *message);
size_t set_scene_request__get_packed_size
                     (const SetSceneRequest   *message);
size_t set_scene_request__pack
                     (const SetSceneRequest   *message,
                      uint8_t             *out);
size_t set_scene_request__pack_to_buffer
                     (const SetSceneRequest   *message,
                      ProtobufCBuffer     *buffer);
SetSceneRequest *
       set_scene_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   set_scene_request__free_unpacked
                     (SetSceneRequest *message,
                      ProtobufCAllocator *allocator);
/* GetSceneResponse methods */
void   get_scene_response__init
                     (GetSceneResponse         *message);
size_t get_scene_response__get_packed_size
                     (const GetSceneResponse   *message);
size_t get_scene_response__pack
                     (const GetSceneResponse   *message,
                      uint8_t             *out);
size_t get_scene_response__pack_to_buffer
                     (const GetSceneResponse   *message,
                      ProtobufCBuffer     *buffer);
GetSceneResponse *
       get_scene_response__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   get_scene_response__free_unpacked
                     (GetSceneResponse *message,
                      ProtobufCAllocator *allocator);
/* Effect methods */
void   effect__init
                     (Effect         *message);
size_t effect__get_packed_size
                     (const Effect   *message);
size_t effect__pack
                     (const Effect   *message,
                      uint8_t             *out);
size_t effect__pack_to_buffer
                     (const Effect   *message,
                      ProtobufCBuffer     *buffer);
Effect *
       effect__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   effect__free_unpacked
                     (Effect *message,
                      ProtobufCAllocator *allocator);
/* UpgradeFirmwareRequest methods */
void   upgrade_firmware_request__init
                     (UpgradeFirmwareRequest         *message);
size_t upgrade_firmware_request__get_packed_size
                     (const UpgradeFirmwareRequest   *message);
size_t upgrade_firmware_request__pack
                     (const UpgradeFirmwareRequest   *message,
                      uint8_t             *out);
size_t upgrade_firmware_request__pack_to_buffer
                     (const UpgradeFirmwareRequest   *message,
                      ProtobufCBuffer     *buffer);
UpgradeFirmwareRequest *
       upgrade_firmware_request__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   upgrade_firmware_request__free_unpacked
                     (UpgradeFirmwareRequest *message,
                      ProtobufCAllocator *allocator);
/* UpgradeFirmwareResponse methods */
void   upgrade_firmware_response__init
                     (UpgradeFirmwareResponse         *message);
size_t upgrade_firmware_response__get_packed_size
                     (const UpgradeFirmwareResponse   *message);
size_t upgrade_firmware_response__pack
                     (const UpgradeFirmwareResponse   *message,
                      uint8_t             *out);
size_t upgrade_firmware_response__pack_to_buffer
                     (const UpgradeFirmwareResponse   *message,
                      ProtobufCBuffer     *buffer);
UpgradeFirmwareResponse *
       upgrade_firmware_response__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   upgrade_firmware_response__free_unpacked
                     (UpgradeFirmwareResponse *message,
                      ProtobufCAllocator *allocator);
/* TimeStamp methods */
void   time_stamp__init
                     (TimeStamp         *message);
size_t time_stamp__get_packed_size
                     (const TimeStamp   *message);
size_t time_stamp__pack
                     (const TimeStamp   *message,
                      uint8_t             *out);
size_t time_stamp__pack_to_buffer
                     (const TimeStamp   *message,
                      ProtobufCBuffer     *buffer);
TimeStamp *
       time_stamp__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data);
void   time_stamp__free_unpacked
                     (TimeStamp *message,
                      ProtobufCAllocator *allocator);
/* --- per-message closures --- */

typedef void (*DeviceInformationRequest_Closure)
                 (const DeviceInformationRequest *message,
                  void *closure_data);
typedef void (*DeviceInformationResponse_Closure)
                 (const DeviceInformationResponse *message,
                  void *closure_data);
typedef void (*SetColorModeRequest_Closure)
                 (const SetColorModeRequest *message,
                  void *closure_data);
typedef void (*SetStaticColorRequest_Closure)
                 (const SetStaticColorRequest *message,
                  void *closure_data);
typedef void (*RTCRequest_Closure)
                 (const RTCRequest *message,
                  void *closure_data);
typedef void (*ListTimePointRequest__Time_Closure)
                 (const ListTimePointRequest__Time *message,
                  void *closure_data);
typedef void (*ListTimePointRequest_Closure)
                 (const ListTimePointRequest *message,
                  void *closure_data);
typedef void (*LightingScheduleRequest_Closure)
                 (const LightingScheduleRequest *message,
                  void *closure_data);
typedef void (*SetSceneRequest_Closure)
                 (const SetSceneRequest *message,
                  void *closure_data);
typedef void (*GetSceneResponse_Closure)
                 (const GetSceneResponse *message,
                  void *closure_data);
typedef void (*Effect_Closure)
                 (const Effect *message,
                  void *closure_data);
typedef void (*UpgradeFirmwareRequest_Closure)
                 (const UpgradeFirmwareRequest *message,
                  void *closure_data);
typedef void (*UpgradeFirmwareResponse_Closure)
                 (const UpgradeFirmwareResponse *message,
                  void *closure_data);
typedef void (*TimeStamp_Closure)
                 (const TimeStamp *message,
                  void *closure_data);

/* --- services --- */


/* --- descriptors --- */

extern const ProtobufCEnumDescriptor    scene__descriptor;
extern const ProtobufCEnumDescriptor    command_code__descriptor;
extern const ProtobufCEnumDescriptor    mode__descriptor;
extern const ProtobufCMessageDescriptor device_information_request__descriptor;
extern const ProtobufCMessageDescriptor device_information_response__descriptor;
extern const ProtobufCMessageDescriptor set_color_mode_request__descriptor;
extern const ProtobufCMessageDescriptor set_static_color_request__descriptor;
extern const ProtobufCMessageDescriptor rtcrequest__descriptor;
extern const ProtobufCMessageDescriptor list_time_point_request__descriptor;
extern const ProtobufCMessageDescriptor list_time_point_request__time__descriptor;
extern const ProtobufCMessageDescriptor lighting_schedule_request__descriptor;
extern const ProtobufCMessageDescriptor set_scene_request__descriptor;
extern const ProtobufCMessageDescriptor get_scene_response__descriptor;
extern const ProtobufCMessageDescriptor effect__descriptor;
extern const ProtobufCMessageDescriptor upgrade_firmware_request__descriptor;
extern const ProtobufCMessageDescriptor upgrade_firmware_response__descriptor;
extern const ProtobufCMessageDescriptor time_stamp__descriptor;

PROTOBUF_C__END_DECLS


#endif  /* PROTOBUF_C_proto_2fmessage_2eproto__INCLUDED */
