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


CREATE INDEX idx_chatmessage_sent ON ChatMessage (sent);
CREATE INDEX idx_chatmessage_chatid_sent ON ChatMessage (chat_id, sent);

