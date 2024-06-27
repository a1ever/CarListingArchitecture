create table if not exists ListingClone
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

insert into ListingClone select * from listing;


create table if not exists FavouriteClone
(
    author_id  uuid references Author (id),
    listing_id uuid references ListingClone (id),
    PRIMARY KEY (listing_id, author_id)
);

insert into FavouriteClone select * from favourite;

drop table favourite;

create table if not exists PhotoClone
(
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    listing_id uuid references ListingClone (id),
    photo bytea not null
);


insert into PhotoClone select * from photo;

drop table photo;

create table if not exists VisitorClone
(
    author_id  uuid references Author (id),
    listing_id uuid references ListingClone (id),
    date DATE not null,
    PRIMARY KEY (listing_id, author_id)
);

insert into VisitorClone select * from visitor;

drop table visitor;

create table if not exists Listing_CategoryClone
(
    listing_id  uuid references ListingClone (id),
    category_id uuid references Category (id),
    PRIMARY KEY (listing_id, category_id)
);


insert into Listing_CategoryClone select * from listing_category;

drop table listing_category;

drop table listing;


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

insert into listing select * from listingclone;


create table if not exists Favourite
(
    author_id  uuid references Author (id),
    listing_id uuid references Listing (id),
    PRIMARY KEY (listing_id, author_id)
);

insert into Favourite select * from Favouriteclone;

create table if not exists Photo
(
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    listing_id uuid references Listing (id),
    photo bytea not null
);

insert into Photo select * from Photoclone;

create table if not exists Visitor
(
    author_id  uuid references Author (id),
    listing_id uuid references Listing (id),
    date DATE not null,
    PRIMARY KEY (listing_id, author_id)
);

insert into Visitor select * from Visitorclone;

create table if not exists Listing_Category
(
    listing_id  uuid references Listing(id),
    category_id uuid references Category (id),
    PRIMARY KEY (listing_id, category_id)
);


insert into Listing_Category select * from Listing_Category2;

drop table listing_category2;

create table IF NOT EXISTS ChatMessageClone
(
    id        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    text      text not null,
    author_id uuid references Author (id),
    chat_id   uuid references Chat (id),
    sent      timestamp NOT NULL
);

insert into ChatMessageClone select * from chatmessage;

drop table chatmessage;

create table IF NOT EXISTS ChatMessage
(
    id        uuid DEFAULT gen_random_uuid(),
    text      text not null,
    author_id uuid references Author (id),
    chat_id   uuid references Chat (id),
    sent      timestamp NOT NULL,
    PRIMARY KEY (id, sent)
) partition by range (sent);

CREATE TABLE IF NOT EXISTS messages_from_first1 PARTITION OF ChatMessage
    FOR VALUES FROM ('2024-05-20 15:07:23.854800') TO ('2024-05-26 15:07:28.831349');
CREATE TABLE IF NOT EXISTS messages_from_first2 PARTITION OF ChatMessage
    FOR VALUES FROM ('2024-05-26 15:07:28.831350') TO ('2024-05-26 15:07:31.771547');
CREATE TABLE IF NOT EXISTS messages_from_first3 PARTITION OF ChatMessage
    FOR VALUES FROM ('2024-05-26 15:07:31.771548') TO ('2024-05-26 15:07:41.952390');
CREATE TABLE IF NOT EXISTS messages_from_first4 PARTITION OF ChatMessage
    FOR VALUES FROM ('2024-05-26 15:07:41.952391') TO ('2024-05-26 15:11:18.462383');
CREATE TABLE IF NOT EXISTS messages_from_first5 PARTITION OF ChatMessage
    FOR VALUES FROM ('2024-05-26 15:11:18.462384') TO ('2024-05-30 21:39:54.496823');
