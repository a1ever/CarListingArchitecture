CREATE INDEX idx_chatmessage_sent ON ChatMessage (sent);
CREATE INDEX idx_chatmessage_chatid_sent ON ChatMessage (chat_id, sent);
CREATE INDEX idx_listing_listing_type ON Listing (listing_type);

CREATE INDEX idx_listing_author_id ON Listing (author_id);

CREATE INDEX idx_listing_brand_id ON Listing (brand_id);

CREATE INDEX idx_listing_status ON Listing (listing_status);

CREATE INDEX idx_author_shop_author_id_shop_id ON Author_Shop (author_id, shop_id);

drop index idx_listing_status;
drop index idx_listing_listing_type;
drop index idx_listing_author_id;

CREATE INDEX idx_listing_listing_type ON Listing  USING HASH (listing_type);

CREATE INDEX idx_listing_author_id ON Listing USING HASH (author_id);

CREATE INDEX idx_listing_status ON Listing  USING HASH  (listing_status);
