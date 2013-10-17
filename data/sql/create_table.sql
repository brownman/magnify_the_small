-- motivation 3
CREATE TABLE thanks(
    id INTEGER PRIMARY KEY,
    content TEXT
  );

CREATE TABLE dream(
    id INTEGER PRIMARY KEY,
    content TEXT
  );

CREATE TABLE did_for_others(
    id INTEGER PRIMARY KEY,
    person CHAR(10),
    description TEXT
);

-- efficiency 2
CREATE TABLE koan(
    id INTEGER PRIMARY KEY,
    proto TEXT,
    input CHAR(10),
    expect  CHAR(10),
    snippet TEXT
);

CREATE TABLE background (
    id INTEGER PRIMARY KEY,
    title CHAR(10),
    feeling CHAR(20),
    command TEXT
);



------------- ground 2
CREATE TABLE frame (
    id INTEGER PRIMARY KEY,
    until CHAR(10),
    goal CHAR(20),
    mini_task TEXT
);

CREATE TABLE priority(
    id INTEGER PRIMARY KEY,
    priority INTEGER,
    title CHAR(10),
    description TEXT
);



--------------learn 2

CREATE TABLE assosiation(
    id INTEGER PRIMARY KEY,
    word CHAR(10),
    lang CHAR(2),
    phonetics CHAR(30)
);

CREATE TABLE grammer(
    id INTEGER PRIMARY KEY,
    tweet TEXT,
    question TEXT,
    answer TEXT,
    url TEXT
);







