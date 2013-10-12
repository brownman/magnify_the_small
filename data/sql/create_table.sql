--ex1
CREATE TABLE notebook (
    id INTEGER PRIMARY KEY,
    doing TEXT,
    should TEXT,
    sport INTEGER
);

CREATE TABLE task(
    id INTEGER PRIMARY KEY,
    time TEXT,
    frame INTEGER,
    task TEXT,
    mini TEXT

);

CREATE TABLE memos(
    id INTEGER PRIMARY KEY,
    priority INTEGER,
    task TEXT
);
