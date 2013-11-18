
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




CREATE TABLE associations (
    id INTEGER PRIMARY KEY,
    word CHAR(30),
    lang CHAR(2),
    phonetics CHAR(30),
    content CHAR(60)
);
CREATE TABLE the_big_picture (
    id INTEGER PRIMARY KEY,
    breakthrough CHAR(40),
    goal CHAR(30),
    estimate CHAR(30),
    mini_task CHAR(30),
    on_suspend CHAR(30),
    do_for_others_first CHAR(40),
    breath CHAR(40),
    funny CHAR(40)
);

CREATE TABLE bookmarks (
    id INTEGER PRIMARY KEY,
    subject CHAR(120),
    tags CHAR(300),
    url CHAR(200)
);
CREATE TABLE push_forward (
    id INTEGER PRIMARY KEY,
    time CHAR(22),
    func CHAR(22),
    details CHAR(200)
);


CREATE TABLE koan (
    id INTEGER PRIMARY KEY,
    code CHAR(400),
    args CHAR(200),
    expect CHAR(200),
    result CHAR(100)
);








