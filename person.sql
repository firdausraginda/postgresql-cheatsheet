CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(150),
    car_id BIGINT REFERENCES car (id),
    UNIQUE(car_id)
);

INSERT INTO person (first_name, last_name, gender, date_of_birth, email)
VALUES ('Fernanda', 'Beardon', 'Female', date '1988-01-09', 'fernandab@is.gd');

INSERT INTO person (first_name, last_name, gender, date_of_birth, email)
VALUES ('Omar', 'Colmore', 'Male', date '1921-04-03', null);

INSERT INTO person (first_name, last_name, gender, date_of_birth, email)
VALUES ('Adriana', 'Matuschek', 'Female', date '1921-04-03', 'amatuschek2@feedburner.com');