create table users
(
    id         uuid      default gen_random_uuid(),
    email      varchar not null,
    password   varchar not null,
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
    created_at   timestamp default now(),
    primary key (id)
);

create unique index devices_token_uindex on devices (token);