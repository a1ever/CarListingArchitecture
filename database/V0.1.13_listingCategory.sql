create table if not exists Listing_Category
(
    listing_id  uuid references Listing (id),
    category_id uuid references Category (id),
    PRIMARY KEY (listing_id, category_id)
);