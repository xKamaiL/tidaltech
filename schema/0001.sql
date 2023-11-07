create table users
(
    id         uuid      default gen_random_uuid(),
    email      varchar not null,
    password   text    not null,
    created_at timestamp default now(),
    primary key (id)
);

create unique index users_email_uindex on users (email);

create table user_auth_tokens
(
    id         bigserial not null,
    user_id    uuid      not null references users (id) on delete cascade,
    token      varchar   not null,
    expires_at timestamp default interval '7 day' + now(),
    created_at timestamp default now(),
    primary key (id)
);

create unique index user_auth_tokens_token_uindex on user_auth_tokens (token);

create table devices
(
    id           uuid      default gen_random_uuid(),
    token        varchar not null,
    name         varchar not null,
    pair_user_id uuid      default null references users (id),
    pair_at      timestamp default null,
    properties   jsonb   not null,
    created_at   timestamp default now(),
    primary key (id)
);

create unique index devices_token_uindex on devices (token);

create table schedule_presets
(
    id          uuid      default gen_random_uuid(),
    user_id     uuid      default null,
    name        varchar not null,
    description text    not null,
    time_points jsonb   not null,
    created_at  timestamp default now(),
    primary key (id)
);

insert into schedule_presets (user_id, name, description, time_points)
values (null,
        'Recommended',
        'Recommended schedule for Tidal Tech Lighting',
        '[
          {
            "time": "08:00",
            "brightness": {
              "red": 74,
              "blue": 77,
              "green": 9,
              "white": 0,
              "royalBlue": 77,
              "warmWhite": 0,
              "ultraViolet": 0
            }
          },
          {
            "time": "09:30",
            "brightness": {
              "red": 74,
              "blue": 100,
              "green": 29,
              "white": 65,
              "royalBlue": 100,
              "warmWhite": 0,
              "ultraViolet": 0
            }
          },
          {
            "time": "15:30",
            "brightness": {
              "red": 74,
              "blue": 74,
              "green": 7,
              "white": 0,
              "royalBlue": 76,
              "warmWhite": 47,
              "ultraViolet": 0
            }
          },
          {
            "time": "18:00",
            "brightness": {
              "red": 0,
              "blue": 4,
              "green": 0,
              "white": 0,
              "royalBlue": 5,
              "warmWhite": 0,
              "ultraViolet": 0
            }
          },
          {
            "time": "24:00",
            "brightness": {
              "red": 0,
              "blue": 4,
              "green": 0,
              "white": 0,
              "royalBlue": 5,
              "warmWhite": 0,
              "ultraViolet": 0
            }
          }
        ]'::jsonb);

insert into devices (id, token, name, pair_user_id, pair_at, properties, created_at)
values ('83ac6d47-82fd-403a-b903-1a7df6248d46', 'TOKEN', 'TIDAL TECH LIGHTING', null, null,
        '{
          "power": true,
          "mode": "schedule",
          "schedule": {
            "points": [],
            "weekday": "0000000"
          }
        }',
        now());


create table scenes
(
    id         varchar not null primary key,
    name       varchar not null,
    icon       varchar not null,
    data       jsonb   not null,
    created_at timestamp default now()
);

insert into scenes (id, name, icon, data)
values ('sunrise', 'Sunrise', 'sunrise', '[
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 77,
      "green": 9,
      "white": 0,
      "royalBlue": 77,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('sunset', 'Sunset', 'sunset', '[
  {
    "duration": 60,
    "color": {
      "red": 0,
      "blue": 4,
      "green": 0,
      "white": 0,
      "royalBlue": 5,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('storm', 'Storm', 'storm', '[
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 77,
      "green": 9,
      "white": 0,
      "royalBlue": 77,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 0,
      "blue": 4,
      "green": 0,
      "white": 0,
      "royalBlue": 5,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('cloudy', 'Cloudy', 'cloudy', '[
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 77,
      "green": 9,
      "white": 0,
      "royalBlue": 77,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 74,
      "green": 7,
      "white": 0,
      "royalBlue": 76,
      "warmWhite": 47,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('lightning', 'Lightning', 'lightning', '[
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 77,
      "green": 9,
      "white": 0,
      "royalBlue": 77,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 74,
      "green": 7,
      "white": 0,
      "royalBlue": 76,
      "warmWhite": 47,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 0,
      "blue": 4,
      "green": 0,
      "white": 0,
      "royalBlue": 5,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('moonlight', 'Moonlight', 'moonlight', '[
  {
    "duration": 60,
    "color": {
      "red": 0,
      "blue": 4,
      "green": 0,
      "white": 0,
      "royalBlue": 5,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('daylight', 'Daylight', 'daylight', '[
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 100,
      "green": 29,
      "white": 65,
      "royalBlue": 100,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');

insert into scenes (id, name, icon, data)
values ('thunderstorm', 'Thunderstorm', 'thunderstorm', '[
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 77,
      "green": 9,
      "white": 0,
      "royalBlue": 77,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 74,
      "green": 7,
      "white": 0,
      "royalBlue": 76,
      "warmWhite": 47,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 0,
      "blue": 4,
      "green": 0,
      "white": 0,
      "royalBlue": 5,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  },
  {
    "duration": 60,
    "color": {
      "red": 74,
      "blue": 77,
      "green": 9,
      "white": 0,
      "royalBlue": 77,
      "warmWhite": 0,
      "ultraViolet": 0
    }
  }
]');