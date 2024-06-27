create table if not exists Photo
(
    id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    listing_id uuid references Listing (id),
    photo bytea not null
);