create table if not exists Listing_Category
(
    listing_id  uuid references Listing (id),
    category_id uuid references Category (id),
    PRIMARY KEY (listing_id, category_id)
);

CREATE INDEX idx_listing_listing_type ON Listing (listing_type);

CREATE INDEX idx_listing_author_id ON Listing (author_id);

CREATE INDEX idx_listing_brand_id ON Listing (brand_id);

CREATE INDEX idx_listing_status ON Listing (listing_status);