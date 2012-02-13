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
    (3, '2012-Feb-08 00:00:00', '2012-Feb-08 11:59:59'),
    (4, '2012-Feb-07 00:00:00', '2012-Feb-07 11:59:59'),
    (5, '2012-Feb-07 12:00:00', '2012-Feb-07 23:59:59'),
    (6, '2012-Feb-08 00:00:00', '2012-Feb-08 11:59:59'),
    (7, '2012-Feb-07 00:00:00', '2012-Feb-07 11:59:59'),
    (8, '2012-Feb-07 12:00:00', '2012-Feb-07 23:59:59'),
    (9, '2012-Feb-08 00:00:00', '2012-Feb-08 11:59:59'),
    (10, '2012-Feb-08 00:00:00', '2012-Feb-08 11:59:59')
;

INSERT INTO prediction (ticker, user_id, time, period, direction)
VALUES
    ('SPX',    1, '2012-Feb-07 01:11:11', 1, 'up'),
    ('EURO50', 1, '2012-Feb-07 01:11:11', 1, 'up'),

    ('SPX',    1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('EURO50', 1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('FTSE',   1, '2012-Feb-07 01:21:11', 1, 'up'),
    ('ASX200', 1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('GOLD',   1, '2012-Feb-07 01:21:11', 1, 'up'),
    ('SILVER', 1, '2012-Feb-07 01:21:11', 1, 'up'),
    ('OIL',    1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('SUGAR',  1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('AUDUSD', 1, '2012-Feb-07 01:21:11', 1, 'down'),
    ('NZDUSD', 1, '2012-Feb-07 01:21:11', 1, 'up'),
    ('EURUSD', 1, '2012-Feb-07 01:21:11', 1, 'up'),
    ('GBPUSD', 1, '2012-Feb-07 01:21:11', 1, 'up'),

    ('SPX',    1, '2012-Feb-07 15:50:00', 2, 'up'),
    ('EURO50', 1, '2012-Feb-07 15:50:00', 2, 'down'),

    ('SPX',    1, '2012-Feb-07 15:55:55', 2, 'down'),
    ('EURO50', 1, '2012-Feb-07 15:55:55', 2, 'down'),

    ('SPX',    1, '2012-Feb-07 01:21:11', 10, 'down'),
    ('EURO50', 1, '2012-Feb-07 01:21:11', 10, 'down'),
    ('FTSE',   1, '2012-Feb-07 01:21:11', 10, 'up'),
    ('ASX200', 1, '2012-Feb-07 01:21:11', 10, 'down'),
    ('GOLD',   1, '2012-Feb-07 01:21:11', 10, 'up'),
    ('SILVER', 1, '2012-Feb-07 01:21:11', 10, 'up'),
    ('OIL',    1, '2012-Feb-07 01:21:11', 10, 'down'),
    ('SUGAR',  1, '2012-Feb-07 01:21:11', 10, 'down'),
    ('AUDUSD', 1, '2012-Feb-07 01:21:11', 10, 'down'),
    ('NZDUSD', 1, '2012-Feb-07 01:21:11', 10, 'up'),
    ('EURUSD', 1, '2012-Feb-07 01:21:11', 10, 'up'),
    ('GBPUSD', 1, '2012-Feb-07 01:21:11', 10, 'up')
;

INSERT INTO period_result (period_id, ticker, direction)
VALUES
    (1, 'SPX',    'up'),
    (1, 'EURO50', 'down'),
    (1, 'FTSE',   'up'),
    (1, 'ASX200', 'up'),
    (1, 'GOLD',   'down'),
    (1, 'SILVER', 'down'),
    (1, 'OIL',    'up'),
    (1, 'SUGAR',  'up'),
    (1, 'AUDUSD', 'down'),
    (1, 'NZDUSD', 'down'),
    (1, 'EURUSD', 'down'),
    (1, 'GBPUSD', 'up'),

    (2, 'SPX',    'up'),
    (2, 'EURO50', 'down'),
    (2, 'FTSE',   'up'),
    (2, 'ASX200', 'up'),
    (2, 'GOLD',   'down'),
    (2, 'SILVER', 'down'),
    (2, 'OIL',    'up'),
    (2, 'SUGAR',  'up'),
    (2, 'AUDUSD', 'down'),
    (2, 'NZDUSD', 'down'),
    (2, 'EURUSD', 'down'),
    (2, 'GBPUSD', 'up'),

    (3, 'SPX',    'up'),
    (3, 'EURO50', 'down'),
    (3, 'FTSE',   'up'),
    (3, 'ASX200', 'up'),
    (3, 'GOLD',   'down'),
    (3, 'SILVER', 'down'),
    (3, 'OIL',    'up'),
    (3, 'SUGAR',  'up'),
    (3, 'AUDUSD', 'down'),
    (3, 'NZDUSD', 'down'),
    (3, 'EURUSD', 'down'),
    (3, 'GBPUSD', 'up'),

    (4, 'SPX',    'up'),
    (4, 'EURO50', 'down'),
    (4, 'FTSE',   'up'),
    (4, 'ASX200', 'up'),
    (4, 'GOLD',   'down'),
    (4, 'SILVER', 'down'),
    (4, 'OIL',    'up'),
    (4, 'SUGAR',  'up'),
    (4, 'AUDUSD', 'down'),
    (4, 'NZDUSD', 'down'),
    (4, 'EURUSD', 'down'),
    (4, 'GBPUSD', 'up'),

    (5, 'SPX',    'up'),
    (5, 'EURO50', 'down'),
    (5, 'FTSE',   'up'),
    (5, 'ASX200', 'up'),
    (5, 'GOLD',   'down'),
    (5, 'SILVER', 'down'),
    (5, 'OIL',    'up'),
    (5, 'SUGAR',  'up'),
    (5, 'AUDUSD', 'down'),
    (5, 'NZDUSD', 'down'),
    (5, 'EURUSD', 'down'),
    (5, 'GBPUSD', 'up'),

    (6, 'SPX',    'up'),
    (6, 'EURO50', 'down'),
    (6, 'FTSE',   'up'),
    (6, 'ASX200', 'up'),
    (6, 'GOLD',   'down'),
    (6, 'SILVER', 'down'),
    (6, 'OIL',    'up'),
    (6, 'SUGAR',  'up'),
    (6, 'AUDUSD', 'down'),
    (6, 'NZDUSD', 'down'),
    (6, 'EURUSD', 'down'),
    (6, 'GBPUSD', 'up'),

    (7, 'SPX',    'up'),
    (7, 'EURO50', 'down'),
    (7, 'FTSE',   'up'),
    (7, 'ASX200', 'up'),
    (7, 'GOLD',   'down'),
    (7, 'SILVER', 'down'),
    (7, 'OIL',    'up'),
    (7, 'SUGAR',  'up'),
    (7, 'AUDUSD', 'down'),
    (7, 'NZDUSD', 'down'),
    (7, 'EURUSD', 'down'),
    (7, 'GBPUSD', 'up'),

    (8, 'SPX',    'up'),
    (8, 'EURO50', 'down'),
    (8, 'FTSE',   'up'),
    (8, 'ASX200', 'up'),
    (8, 'GOLD',   'down'),
    (8, 'SILVER', 'down'),
    (8, 'OIL',    'up'),
    (8, 'SUGAR',  'up'),
    (8, 'AUDUSD', 'down'),
    (8, 'NZDUSD', 'down'),
    (8, 'EURUSD', 'down'),
    (8, 'GBPUSD', 'up'),

    (9, 'SPX',    'up'),
    (9, 'EURO50', 'down'),
    (9, 'FTSE',   'up'),
    (9, 'ASX200', 'up'),
    (9, 'GOLD',   'down'),
    (9, 'SILVER', 'down'),
    (9, 'OIL',    'up'),
    (9, 'SUGAR',  'up'),
    (9, 'AUDUSD', 'down'),
    (9, 'NZDUSD', 'down'),
    (9, 'EURUSD', 'down'),
    (9, 'GBPUSD', 'up'),

    (10, 'SPX',    'up'),
    (10, 'EURO50', 'down'),
    (10, 'FTSE',   'up'),
    (10, 'ASX200', 'up'),
    (10, 'GOLD',   'down'),
    (10, 'SILVER', 'down'),
    (10, 'OIL',    'up'),
    (10, 'SUGAR',  'up'),
    (10, 'AUDUSD', 'down'),
    (10, 'NZDUSD', 'down'),
    (10, 'EURUSD', 'down'),
    (10, 'GBPUSD', 'up')
;

COMMIT;
