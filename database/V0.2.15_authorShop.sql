create table IF NOT EXISTS Author_Shop
(
    author_id uuid UNIQUE REFERENCES Author (id),
    shop_id   uuid REFERENCES Shop (id),
    PRIMARY KEY (author_id, shop_id)
);

CREATE INDEX idx_author_shop_author_id_shop_id ON Author_Shop (author_id, shop_id);