create table if not exists Favourite
(
    author_id  uuid references Author (id),
    listing_id uuid references Listing (id),
    PRIMARY KEY (listing_id, author_id)
);