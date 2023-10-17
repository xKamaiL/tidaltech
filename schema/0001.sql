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
    id         uuid      default gen_random_uuid(),
    user_id    uuid    not null references users (id) on delete cascade,
    token      varchar not null,
    expires_at timestamp default interval '7 day' + now(),
    created_at timestamp default now(),
    primary key (id)
);