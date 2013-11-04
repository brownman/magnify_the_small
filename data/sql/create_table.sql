
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
