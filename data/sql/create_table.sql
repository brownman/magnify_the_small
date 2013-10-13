--ex1
CREATE TABLE notebook (
    id INTEGER PRIMARY KEY,
    time TEXT,
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


CREATE TABLE priority(
    id INTEGER PRIMARY KEY,
    urgency INTEGER,
    person TEXT,
    task TEXT,
    description TEXT
);

CREATE TABLE assosiation(
    id INTEGER PRIMARY KEY,
    word TEXT,
    lang TEXT,
    phonetics TEXT,
    image TEXT
);



