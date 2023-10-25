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