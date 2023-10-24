#ifndef SCHEDULE_H
#define SCHEDULE_H

#include <functional>
#include <vector>

#include "nvs_flash.h"
#define NAMESPACE "schedule"

typedef struct {
    unsigned short hh;
    unsigned short mm;
    unsigned short white;
    unsigned short warm_white;
    unsigned short red;
    unsigned short green;
    unsigned short blue;
    unsigned short royal_blue;
    unsigned short ultra_violet;
} LEDLevel;

typedef struct {
    bool ok;
    unsigned short hh;
    unsigned short mm;
    LEDLevel leds;
} Schedule;

extern esp_err_t write_schedule_to_nvs(const std::vector<Schedule> &items);
extern esp_err_t read_schedule_from_nvs(std::vector<Schedule> &schedules);
extern std::vector<Schedule> filter_schedules(std::vector<Schedule> &schedules, std::function<bool(const Schedule &)> condition);
extern void upsert_schedules(std::vector<Schedule> &schedules, const Schedule &newSchedule);
extern void debug_schedules();

#endif  // SCHEDULE_H