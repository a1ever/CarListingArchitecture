create table if not exists Author_Chat
(
    author_id uuid references Author (id),
    chat_id   uuid references Chat (id),
    PRIMARY KEY (author_id, chat_id)
);