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

create table devices
(
    id             uuid primary key,
    label          text not null,
    paired_user_id uuid references users (id) default null,
    pair_code      text not null,
    mode           smallint                   default 1,
    led_states     jsonb                      default null,
    created_at     timestamptz                default now(),
    updated_at     timestamptz                default now()
);

create table device_lighting
(
    id         uuid primary key,
    device_id  uuid references devices (id),
    -- TODO: store lighting config
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

