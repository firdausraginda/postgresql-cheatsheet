-- DATABASE --------------------------------------------
-- to get list of databases
\l

-- to create new database
CREATE DATABASE <db_name>

-- to delete database
DROP DATABASE <db_name>

-- to connect to database
\c <db_name>

-- to connect to database with specific user
\c <db_name> <user_name>

-- USER --------------------------------------------

-- to get list or users with the privileges info
\du

-- to create user with password
CREATE USER <user_name> WITH ENCRYPTED PASSWORD '<password>';

-- to grant all privileges on certain database to a user
GRANT ALL PRIVILEGES ON DATABASE <database_name> to <user_name>;

-- to drop user
DROP USER <user_name>;

-- SCHEMA --------------------------------------------

-- to get list of schemas
\dn

-- to create schema and its authorization
CREATE SCHEMA <schema_name> AUTHORIZATION <user_name>;

-- to show the active schema
SHOW search_path;

-- to set to new schema
SET search_path to <schema_name>;

-- to drop schema
DROP SCHEMA <schema_name>;

-- TABLE --------------------------------------------
-- to get list of tables
\d

-- to get more detail about table
\d <table_name>

-- to create new table with respective column & data type
-- postgres list of data types: https://www.postgresql.org/docs/11/datatype.html
CREATE TABLE <table_name> (
  <column_name> <data_type> [NOT NULL] [PRIMARY KEY],
  <column_name> <data_type> [NOT NULL]
);

CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(150)
);

-- to create table with foreign key
CREATE TABLE <table_name> (
  <column_name> <data_type> [NOT NULL] [PRIMARY KEY],
  <column_name> <data_type> REFERENCES <referenced_table_name>(<referenced_column_name>)
);

CREATE TABLE family (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  person_id BIGSERIAL REFERENCES person(id)
);

-- to set delete types for referenced table
-- delete types: CASCADE, RESTRICT, SET NULL, SET DEFAULT
CREATE TABLE <table_name> (
  <column_name> <data_type> [NOT NULL] [PRIMARY KEY],
  <column_name> <data_type> REFERENCES <referenced_table_name>(<referenced_column_name>) ON DELETE <delete_type>
);

CREATE TABLE family (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  person_id BIGSERIAL REFERENCES person(id) ON DELETE CASCADE
);

-- to delete a table
DROP TABLE <table_name>

-- to insert values to a table
INSERT INTO <table_name> (column1, column2, column3)
VALUES (value1, value2, value3);

INSERT INTO person (first_name, last_name, gender, date_of_birth, email)
VALUES ('Anne', 'Smith', 'FEMALE', date '1988-01-09', 'annesmith@gmail.com');

-- to get the table content
select *
from <table_name>

-- to execute command from file
\i <file_path>

-- CONSTRAINT --------------------------------------------
-- add constraint unique to email column
ALTER TABLE <table_name> ADD CONSTRAINT <random_constraint_name> UNIQUE (<column_name>);
ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE (email);

-- add constraint check to gender column
ALTER TABLE <table_name> ADD CONSTRAINT <random_constraint_name> CHECK (<check_rule>);
ALTER TABLE person ADD CONSTRAINT gender_check_constraint CHECK (gender IN ('Genderqueer', 'Bigender', 'Genderfluid', 'Male', 'Polygender', 'Non-binary', 'Female', 'Agender'));

-- to add foreign key constraint and delete type
ALTER TABLE <table_name> ADD CONSTRAINT <random_constraint_name> FOREIGN KEY (<foreign_key_column>) REFERENCES <referenced_table_name>(<referenced_column_name>) ON DELETE <delete_type>;
ALTER TABLE family ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;

-- delete constraint
ALTER TABLE <table_name> DROP CONSTRAINT <random_constraint_name>;
ALTER TABLE person DROP CONSTRAINT unique_email_address;

-- DELETE RECORDS --------------------------------------------
-- to delete all records
DELETE FROM <table_name>;

-- to delete specific records
DELETE FROM <table_name> WHERE <condition>;

-- UPDATE RECORDS --------------------------------------------
-- to update all records
UPDATE <table_name> SET <column_name> = <value>;
UPDATE person SET email = 'newEmail@gmail.com';

-- to update specific records
UPDATE <table_name> SET <column_name> = <value> WHERE <condition>;
UPDATE person SET email = 'corrine@gmail.com', last_name = 'elizabeth' WHERE id = 2;

-- DUPLICATE KEYS ERROR HANDLING --------------------------------------------
-- on conlict do nothing => do nothing if the key already exists in the table
INSERT INTO <table_name> (column1, column2, column3)
VALUES (value1, value2, value3)
ON CONFLICT (<column_name>) DO NOTHING;

INSERT INTO person (id, first_name, last_name, gender, date_of_birth, email)
VALUES (1, 'Sukinem', 'Marfuah', 'Female', date '2000-01-01', 'marfuah@gmail.com')
ON CONFLICT (id) DO NOTHING;

-- upsert / on conflict do update => if encounter conflict then use the latest one
INSERT INTO <table_name> (column1, column2, column3)
VALUES (value1, value2, value3)
ON CONFLICT (<column_name>) DO UPDATE SET <column_name> = EXCLUDED.<column_name>;

INSERT INTO person (id, first_name, last_name, gender, date_of_birth, email)
VALUES (1, 'Sukinem', 'Marfuah', 'Female', date '2000-01-01', 'marfuah@gmail.com')
ON CONFLICT (id) DO UPDATE SET first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name, email = EXCLUDED.email;

-- TABLE RELATIONS --------------------------------------------
-- to get list of relations
\dt

-- update foreign key column
UPDATE <table_name> SET <fk_column_name> = <referenced_fk_column_name> 
FROM <referenced_table_name> 
WHERE <column_name> = <column_value>;

UPDATE affiliations SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;

-- SEQUENCE --------------------------------------------
-- restart the sequence to 1
ALTER SEQUENCE <sequence_name> RESTART WITH <number>;
ALTER SEQUENCE person_id_seq RESTART WITH 1;