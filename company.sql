
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users(
    user_pk             TEXT,
    user_username       TEXT UNIQUE,
    user_name           TEXT,
    user_last_name      TEXT,
    user_email          TEXT UNIQUE,
    user_password       TEXT,
    user_blocked_at     TEXT,
    user_updated_at     TEXT,
    PRIMARY KEY(user_pk)
) WITHOUT ROWID;

-- Database seeding - when youre inserting data so you can play with the data
INSERT INTO users VALUES ("dbd8c79b-1432-4398-a2f8-75dff97bd62b", "santiagodonoso", "Santiago", "Donoso", "sand@kea.dk", "password", 0, 0);
INSERT INTO users VALUES ("a23b1bfc-d090-4848-a1b6-bf60e8c9b352", "peter", "Peter", "Aa", "a@a.com", "password", 0, 0);
INSERT INTO users VALUES ("aadea47c-6255-4db0-b81e-dbc77f697d2e", "marie", "Marie", "Bb", "b@b.com", "password", 0, 0);
INSERT INTO users VALUES ("2eb59011-bf9c-4a17-a7ff-42ff6a87403d", "maria", "Maria", "Cc", "c@c.com", "password", 0, 0);
INSERT INTO users VALUES ("36798f3c-7ae6-4c62-9ec3-6632cc61a04c", "sofie", "Sofie", "Dd", "d@d.com", "password", 0, 0);
INSERT INTO users VALUES ("36798f3c-7ae6-4c62-9ec3-6632cc61a05c", "sofia", "Sofia", "Ee", "e@e.com", "password", 0, 0);
INSERT INTO users VALUES ("36798f3c-7ae6-4c62-9ec3-6632cc61a06c", "tomas", "Tomas", "Ff", "f@f.com", "password", 0, 0);
INSERT INTO users VALUES ("36798f3c-7ae6-4c62-9ec3-6632cc61a07c", "tomine", "Tomine", "Gg", "g@g.com", "password", 0, 0);

INSERT INTO users VALUES ("36798f3c-7ae6-4c62-9ec3-6632cc61a08c", "tominex", "Tominexx", "Gg", "tomxxx@x.com", "password", 0, 0);

EXPLAIN SELECT * FROM users;

CREATE UNIQUE INDEX IF NOT EXISTS idx_users_user_name ON users(user_name);

-- The collate nocase makes it case insensitive
-- the EXPLAIN QUERY PLAN show if its indexing
EXPLAIN QUERY PLAN SELECT user_name FROM users WHERE user_name = "sofie" COLLATE NOCASE;

--TRIGGER TO UPDATE user_updated_at - it could also have the AFTER INSERT, DELETE and so on
-- Usually you have one trigger for one action, so INSERT and UPDATE could be in the same trigger but its better to have it in two different ones
CREATE TRIGGER update_user_updated_at
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    UPDATE users
    SET user_updated_at = strftime("%s", "now")
    WHERE user_pk = NEW.user_pk;
END;
-- Update that updates a specific user (and the updated_at will update also)
UPDATE users
SET user_name = "Kevin"
WHERE user_name = "Maria";

-- View
CREATE VIEW view_test AS
SELECT user_pk, user_name, user_last_name
FROM users
WHERE user_name LIKE "%a%";
-- Instead of always selecting all of the select statement, you can just select the view query:
SELECT * FROM view_test;

-- ##############################
-- Phones table and data
DROP TABLE IF EXISTS phones;
-- Lookup table
CREATE TABLE phones(
    user_fk         TEXT,
    phone_number    TEXT,
    PRIMARY KEY(user_fk, phone_number), -- Composite key
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE -- Constraint
) WITHOUT ROWID;

-- FOREIGN KEY(trackartist) REFERENCES artist(artistid)
INSERT INTO phones VALUES("1", "111");
SELECT * FROM phones;

DELETE FROM users WHERE user_pk = "1";
SELECT * FROM phones;


SELECT * FROM users WHERE user_email = "sand@kea.dk" AND user_password="password"











