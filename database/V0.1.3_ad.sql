create table if not exists Advertisment
(
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    description     text not null ,
    additional_info text not null
);