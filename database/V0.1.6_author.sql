create table IF NOT EXISTS Author
(
    id      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name    VARCHAR(254) not null,
    phone   varchar(25) not null,
    tg_link varchar(254) not null,
    role    author_role
);