create table users
(
    id         uuid primary key,
    username   text not null,
    password   text not null,
    email      text not null,
    avatar_url text        default null,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create table firmware_versions
(
    id           uuid primary key,
    name         text not null,
    version      text not null,
    release_note text not null,
    binary_url   text not null,
    created_at   timestamptz default now(),
    updated_at   timestamptz default now()
);

create table devices
(
    id             uuid primary key,
    label          text not null,
    paired_user_id uuid references users (id) default null,
    pair_code      text not null,
    mode           smallint                   default 1,
    led_states     jsonb                      default null,
    version        text                       default null,
    created_at     timestamptz                default now(),
    updated_at     timestamptz                default now()
);


create table device_lighting
(
    id         uuid primary key,
    device_id  uuid references devices (id),

    mode       smallint    default 1,
    brightness jsonb       default '{
      "red": 0,
      "green": 0,
      "blue": 0,
      "royalBlue": 0,
      "white": 0,
      "warmWhite": 0,
      "ultraviolet": 0
    }'::jsonb,

    schedule   jsonb       default '{
      "points": []
    }'::jsonb,

    effect     jsonb       default '{
      "type": "none",
      "duration": 0,
      "intensity": 0
    }'::jsonb,

    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create table time_schedule_profiles
(
    id          uuid primary key,
    name        text not null,
    description text not null,
    image_url   text not null,

    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

