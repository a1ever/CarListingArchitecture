create table IF NOT EXISTS Chat
(
    id        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    is_opened BOOLEAN default true
);