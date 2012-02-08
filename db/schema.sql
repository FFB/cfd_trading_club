BEGIN;

CREATE DOMAIN direction AS TEXT
CHECK(
    VALUE <> 'up'
 OR VALUE <> 'down'
 OR VALUE <> 'none'
);

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
    id          VARCHAR PRIMARY KEY,
    text        VARCHAR
);

CREATE TABLE period (
    id          INTEGER PRIMARY KEY,
    start_time  TIMESTAMP NOT NULL,
    end_time    TIMESTAMP NOT NULL
);

CREATE TABLE prediction (
    id          SERIAL PRIMARY KEY,
    ticker      VARCHAR NOT NULL REFERENCES ticker(id),
    user_id     INTEGER NOT NULL REFERENCES users(id),
    time        TIMESTAMPTZ NOT NULL,
    period      INTEGER REFERENCES period(id),
    direction   direction NOT NULL
);

CREATE TABLE latest_price (
    ticker      VARCHAR NOT NULL REFERENCES ticker(id),
    time        TIMESTAMPTZ NOT NULL,
    price       NUMERIC NOT NULL,
    PRIMARY KEY (ticker, time)
);

CREATE TABLE competition_price (
    id          SERIAL PRIMARY KEY,
    ticker      VARCHAR NOT NULL REFERENCES ticker(id),
    time        TIMESTAMPTZ NOT NULL,
    price       NUMERIC NOT NULL
);

CREATE TABLE period_result (
    period_id   INTEGER NOT NULL REFERENCES period(id),
    ticker      VARCHAR NOT NULL REFERENCES ticker(id),
    direction   direction NOT NULL,
    PRIMARY KEY (period_id, ticker)
);

INSERT INTO users VALUES (1, 'zane', 'z', 'zmos003', 4893512, 'zjmoser@gmail.com', 'zane', 'moser', '021 163 5403', 'BCom/BE', 'Eco, Fin, SE', '4th Year', 'experienced');
INSERT INTO role (rolename) VALUES ('member'), ('admin');
INSERT INTO user_role VALUES (1,1), (1,2);

INSERT INTO ticker (id, text)
VALUES
    ('SPX', 'S&P500'),
    ('EURO50', 'Euro50'),
    ('FTSE', 'FTSE'),
    ('ASX200', 'ASX200'),
    ('GOLD', 'Gold'),
    ('SILVER', 'Silver'),
    ('OIL', 'Oil'),
    ('SUGAR', 'Sugar'),
    ('AUDUSD', 'AUDUSD'),
    ('NZDUSD', 'NZDUSD'),
    ('EURUSD', 'EURUSD'),
    ('GBPUSD', 'GBPUSD')
;

INSERT INTO period (id, start_time, end_time)
VALUES
    (1, '2012-Feb-07 00:00:00', '2012-Feb-07 11:59:59'),
    (2, '2012-Feb-07 12:00:00', '2012-Feb-07 23:59:59'),
    (3, '2012-Feb-08 00:00:00', '2012-Feb-08 11:59:59')
;

INSERT INTO prediction (ticker, user_id, time, period, direction)
VALUES
    ('SPX',    1, '2012-Feb-07 01:11:11', 1, 'up'),
    ('EURO50', 1, '2012-Feb-07 01:11:11', 1, 'up'),

    ('SPX',    1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('EURO50', 1, '2012-Feb-07 01:21:11', 1, 'up'),

    ('SPX',    1, '2012-Feb-07 15:50:00', 2, 'up'),
    ('EURO50', 1, '2012-Feb-07 15:50:00', 2, 'down'),

    ('SPX',    1, '2012-Feb-07 15:55:55', 2, 'down'),
    ('EURO50', 1, '2012-Feb-07 15:55:55', 2, 'down')
;

INSERT INTO period_result (period_id, ticker, direction)
VALUES
    (1, 'SPX',    'up'),
    (1, 'EURO50', 'up'),

    (2, 'SPX',    'down'),
    (2, 'EURO50', 'up')
;

COMMIT;
