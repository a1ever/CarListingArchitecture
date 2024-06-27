create table if not exists Visitor
(
    author_id  uuid references Author (id),
    listing_id uuid references Listing (id),
    date DATE not null,
    PRIMARY KEY (listing_id, author_id)
);