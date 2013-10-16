--ex2
CREATE TABLE tag (
    id INTEGER PRIMARY KEY,
    word TEXT
);

CREATE TABLE sentence (
    id INTEGER PRIMARY KEY,
    words TEXT
);

CREATE TABLE sentence_tag (
    tag_id INTEGER,
    sentence_id INTEGER
);

