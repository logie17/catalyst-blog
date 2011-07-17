CREATE TABLE entry (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(250),
    markup TEXT,
    html TEXT,
    post_date DATE,
    author INTEGER REFERENCES author(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE comment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    comment TEXT,
    entry_id INTEGER REFERENCES entry(id) ON DELETE CASCADE ON UPDATE CASCADE,
    user_id INTEGER REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE author(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(250),
    last_name VARCHAR(250), 
    username VARCHAR(250), 
    password VARCHAR(250)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(250),
    password VARCHAR(250),
    full_name VARCHAR(250),
    email VARCHAR(250)
);



