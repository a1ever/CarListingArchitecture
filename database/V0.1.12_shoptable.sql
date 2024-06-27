create table IF NOT EXISTS Shop
(
    id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name        VARCHAR(254) not null unique,
    description text not null,
    owner_id    uuid REFERENCES Author (id)
);