create table if not exists Brand
(
    id   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar(254) unique not null
);