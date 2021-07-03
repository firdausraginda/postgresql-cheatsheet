CREATE TABLE car (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price NUMERIC(19,2) NOT NULL
);

INSERT INTO car (make, model, price)
VALUES ('Land Rover', 'Sterlling', '87665.38');

INSERT INTO car (make, model, price)
VALUES ('GMC', 'Acadia', '17662.69');