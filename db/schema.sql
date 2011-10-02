BEGIN;

CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    username    VARCHAR NOT NULL UNIQUE,
    password    VARCHAR NOT NULL,
    upi         VARCHAR NOT NULL UNIQUE,
    student_id  INTEGER NOT NULL UNIQUE,
    email       VARCHAR NOT NULL UNIQUE,
    first_name  VARCHAR NOT NULL,
    last_name   VARCHAR NOT NULL,
    mobile      VARCHAR,
    degree      VARCHAR NOT NULL,
    major       VARCHAR,
    year        VARCHAR NOT NULL,
    experience  VARCHAR NOT NULL
);

CREATE TABLE role (
    id          SERIAL PRIMARY KEY,
    rolename    VARCHAR NOT NULL UNIQUE
);

CREATE TABLE user_role (
    user_id     INTEGER REFERENCES users(id) ON DELETE CASCADE,
    role_id     INTEGER REFERENCES role(id)  ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE ticker (
    id          SERIAL PRIMARY KEY,
    code        VARCHAR NOT NULL UNIQUE,
    text        VARCHAR,
    image       VARCHAR NOT NULL UNIQUE
);

CREATE TABLE prediction (
    id          SERIAL PRIMARY KEY,
    t_id        INTEGER NOT NULL REFERENCES ticker(id) ON DELETE CASCADE,
    user_id     INTEGER NOT NULL REFERENCES users(id),
    time        TIMESTAMPTZ NOT NULL,
    direction   VARCHAR NOT NULL,
    confd       INTEGER NOT NULL
);

INSERT INTO users VALUES (1, 'zane', 'z', 'zmos003', 4893512, 'zjmoser@gmail.com', 'zane', 'moser', '021 163 5403', 'BCom/BE', 'Eco, Fin, SE', '4th Year', 'experienced');
INSERT INTO role (rolename) VALUES ('member'), ('admin');
INSERT INTO user_role VALUES (1,1), (1,2);

COMMIT;
