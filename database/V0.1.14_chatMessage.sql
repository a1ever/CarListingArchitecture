create table IF NOT EXISTS ChatMessage
(
    id        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    text      text not null,
    author_id uuid references Author (id),
    chat_id   uuid references Chat (id),
    sent      timestamp NOT NULL DEFAULT now()
);