PRAGMA foreign_keys=OFF;
    id INTEGER PRIMARY KEY,
    achievments TEXT,
    doing TEXT,
    should TEXT,
    sport INTEGER,
    points INTEGER
);
INSERT INTO `notebook` VALUES(1,'1','1','1',1,1);
    id INTEGER PRIMARY KEY,
    time1 TEXT,
    time2 TEXT,
    goal TEXT,
    mini_task TEXT,
    frame INTEGER
);
INSERT INTO `task` VALUES(1,'1','1','1','1',1);
    id INTEGER PRIMARY KEY,
    priority INTEGER,
    title TEXT,
    content TEXT,
    tags TEXT
);
INSERT INTO `idea` VALUES(1,1,'1','1','1');
    id INTEGER PRIMARY KEY,
    priority INTEGER,
    title TEXT,
    description TEXT
);
INSERT INTO `priority` VALUES(1,1,'1','1');
    id INTEGER PRIMARY KEY,
    thanks TEXT,
    easy TEXT,
    breakthrough TEXT,
    motivation TEXT
);
INSERT INTO `thanks` VALUES(1,'1','1','1','1');
    id INTEGER PRIMARY KEY,
    person TEXT,
    description TEXT
);
INSERT INTO `do_for_others` VALUES(1,'1','1');
    id INTEGER PRIMARY KEY,
    title TEXT,
    description TEXT
);
INSERT INTO `fun_to_imagine` VALUES(1,'1','1');
    id INTEGER PRIMARY KEY,
    word TEXT,
    lang TEXT,
    phonetics TEXT,
    image TEXT
);
INSERT INTO `assosiation` VALUES(1,'1','1','1','1');
    id INTEGER PRIMARY KEY,
    tweet TEXT,
    question TEXT,
    answer TEXT,
    url TEXT
);
INSERT INTO `grammer` VALUES(1,'1','1','1','1');
