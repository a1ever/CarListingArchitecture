create table if not exists Category
(
    id   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar(254) UNIQUE not null
);