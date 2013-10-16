--ex1
CREATE TABLE notebook (
    id INTEGER PRIMARY KEY,
    date TEXT,
    time TEXT,
    frame INTEGER,
    goal TEXT,
    mini_task TEXT,
    remind TEXT,
    sport INTEGER
);


CREATE TABLE idea(
    id INTEGER PRIMARY KEY,
    priority INTEGER,
    title TEXT,
    description TEXT,
    person TEXT,
    url TEXT,
    tags TEXT
);

CREATE TABLE assosiation(
    id INTEGER PRIMARY KEY,
    word TEXT,
    lang TEXT,
    phonetics TEXT,
    image TEXT
);




