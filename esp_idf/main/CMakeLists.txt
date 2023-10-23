# Edit following two lines to set component requirements (see docs)
set(COMPONENT_REQUIRES )
set(COMPONENT_PRIV_REQUIRES )

set(COMPONENT_SRCS "schedule.cpp" "main.cpp" "callback.cpp" "ble_manager.cpp" "proto/message.pb-c.c" "wifi_manager.cpp" )
set(COMPONENT_ADD_INCLUDEDIRS ".")

register_component()
