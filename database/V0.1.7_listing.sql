create table if not exists Listing
(
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name    varchar(254) not null,
    listing_status  listing_status not null,
    price           integer not null ,
    amount          smallint         DEFAULT 1,
    description     text not null ,
    wholesale_price integer          DEFAULT 0,
    listing_type    listing_type not null,
    location        varchar(254) not null,
    author_id       uuid references Author (id),
    advertisment_id uuid references Advertisment (id),
    brand_id        uuid references Brand (id),
    chat_id         uuid references Chat (id),
    tg_id           integer not null
);