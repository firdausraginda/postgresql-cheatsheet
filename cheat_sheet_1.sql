-- DATABASE --------------------------------------------
-- to get list of databases
\l

-- to create new database
CREATE DATABASE <db_name>

-- to delete database
DROP DATABASE <db_name>

-- to connect to database
\c <db_name>


-- TABLE --------------------------------------------
-- to get list of tables
\d

-- to get more detail about table
\d <table_name>

-- to create new table with respective column & data type
-- postgres list of data types: https://www.postgresql.org/docs/11/datatype.html
CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(150)
)

-- to delete a table
DROP TABLE <table_name>

-- to insert values to a table
INSERT INTO person (first_name, last_name, gender, date_of_birth, email)
VALUES ('Anne', 'Smith', 'FEMALE', date '1988-01-09', 'annesmith@gmail.com')

-- to get the table content
select *
from <table_name>

-- to execute command from file
\i <file_path>