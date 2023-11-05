#ifndef TIMESYNC_H
#define TIMESYNC_H

#include <string>

#define NTP_SERVER "pool.ntp.org"
#define TIMEZONE 7

void initialize_sntp();

tm obtain_time();

#endif  // TIMESYNC_H