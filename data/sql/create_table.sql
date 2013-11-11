
CREATE TABLE logger (
    id INTEGER PRIMARY KEY,
    time CHAR(10),
    command CHAR(30),
    args CHAR(60)
);


CREATE TABLE words (
    id INTEGER PRIMARY KEY,
    lang CHAR(30),
    input CHAR(30),
    output CHAR(60),
    phonetics CHAR(60)
);


CREATE UNIQUE INDEX output ON words(output ASC);

CREATE TABLE priorities (
    id INTEGER PRIMARY KEY,
    title CHAR(10),
    content CHAR(60),
    priority INTEGER
);

CREATE TABLE tweets (
    id INTEGER PRIMARY KEY,
    content CHAR(120)
);
CREATE TABLE tweets (
    id INTEGER PRIMARY KEY,
    content CHAR(120)
);
