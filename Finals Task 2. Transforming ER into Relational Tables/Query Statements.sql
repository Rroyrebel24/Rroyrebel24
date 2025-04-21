CREATE DATABASE submission_db;
USE submission_db;
CREATE TABLE student (
    username VARCHAR(50) PRIMARY KEY
);
CREATE TABLE assignment (
    shortname VARCHAR(50) PRIMARY KEY,
    due_date DATE NOT NULL,
    url VARCHAR(255)
);
CREATE TABLE submission (
    username VARCHAR(50) NOT NULL,
    shortname VARCHAR(50) NOT NULL,
    sub_version INT NOT NULL,
    submit_date DATE NOT NULL,
    sub_data TEXT,
    PRIMARY KEY (username, shortname, sub_version),
    FOREIGN KEY (username) REFERENCES student(username),
    FOREIGN KEY (shortname) REFERENCES assignment(shortname)
);
