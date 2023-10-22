
#include "schedule.h"

#include "nvs_flash.h"

esp_err_t write_schedule_to_nvs(const std::vector<Schedule> &items) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READWRITE, &handle);
    if (err != ESP_OK) {
        return err;
    }

    size_t size = items.size() * sizeof(Schedule);               // Calculate the size of the data
    err = nvs_set_blob(handle, "schedule", items.data(), size);  // Use items.data() to get the pointer to the vector's data

    if (err != ESP_OK) {
        nvs_close(handle);
        return err;  // Return the error code if nvs_set_blob fails
    }

    err = nvs_commit(handle);
    nvs_close(handle);

    return err;  // Return the result of nvs_commit
}

esp_err_t read_schedule_from_nvs(std::vector<Schedule> &schedules) {
    nvs_handle_t handle;
    esp_err_t err;

    err = nvs_open(NAMESPACE, NVS_READONLY, &handle);
    if (err != ESP_OK) {
        return err;
    }

    size_t size = 0;
    err = nvs_get_blob(handle, "schedule", nullptr, &size);
    if (err != ESP_OK) {
        nvs_close(handle);
        return err;
    }

    schedules.resize(size / sizeof(Schedule));
    err = nvs_get_blob(handle, "schedule", schedules.data(), &size);
    nvs_close(handle);

    if (err != ESP_OK) {
        return err;
    }

    return ESP_OK;
}

std::vector<Schedule> filter_schedules(std::vector<Schedule> &schedules, std::function<bool(const Schedule &)> condition) {
    std::vector<Schedule> filteredSchedules;
    std::copy_if(schedules.begin(), schedules.end(), std::back_inserter(filteredSchedules), condition);
    return filteredSchedules;
}

void upsert_schedules(std::vector<Schedule> &schedules, const Schedule &newSchedule) {
    auto it = std::find_if(schedules.begin(), schedules.end(), [&](const Schedule &s) {
        // ok = true mean this is a valid schedule
        return s.hh == newSchedule.hh && s.mm == newSchedule.mm && s.ok == true;
    });

    if (it != schedules.end()) {
        *it = newSchedule;
    } else {
        schedules.push_back(newSchedule);
    }
}