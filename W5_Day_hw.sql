--Create all the tables

CREATE TABLE salesperson (
    salesperson_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE mechanic (
    mechanic_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE car (
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(100),
    year INTEGER,
    price NUMERIC(11, 2),
    serial_number VARCHAR(50) NOT NULL UNIQUE,
    salesperson_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE invoice (
    invoice_id SERIAL PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(11, 2),
    car_id INTEGER NOT NULL,
    FOREIGN KEY(car_id) REFERENCES car(car_id)
);

CREATE TABLE service_ticket (
    ticket_id SERIAL PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    car_id INTEGER NOT NULL,
    mechanic_id INTEGER NOT NULL,
    FOREIGN KEY(car_id) REFERENCES car(car_id),
    FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);

CREATE TABLE service_archive (
    record_id SERIAL PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    serial_number VARCHAR(50) NOT NULL,
    mechanic_id INTEGER NOT NULL,
    FOREIGN KEY(serial_number) REFERENCES car(serial_number),
    FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);

CREATE TABLE car_mechanic (
    car_id INTEGER NOT NULL,
    mechanic_id INTEGER NOT NULL,
    FOREIGN KEY(car_id) REFERENCES car(car_id),
    FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);

--===================================================================

--Stored procedure

CREATE OR REPLACE PROCEDURE insert_customer(first_name VARCHAR(50), last_name VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customer (first_name, last_name)
    VALUES (first_name, last_name);
END;
$$;

CALL Insert_Customer('John', 'Smith');
CALL Insert_Customer('Jane', 'Smith');

CREATE OR REPLACE PROCEDURE insert_salesperson(first_name VARCHAR(50), last_name VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO salesperson (first_name, last_name)
    VALUES (first_name, last_name);
END;
$$;

CALL Insert_salesperson('Bill', 'Salesguy');
CALL Insert_salesperson('Jill', 'Saleswoman');

--=====================================================

--Insert the rest of the data

INSERT INTO car (make, model, YEAR, price, serial_number, salesperson_id, customer_id)
    VALUES ('Toyota', 'Sequoia', 2024, 62459, 'A4921TL77', 1, 1);

INSERT INTO car (make, model, YEAR, price, serial_number, salesperson_id, customer_id)
VALUES ('Toyota', 'RAV4', 2024, 30125, 'S54387YC12', 2, 2);

INSERT INTO invoice (total_amount, car_id)
    VALUES (65117, 1);
    
INSERT INTO invoice (total_amount, car_id)
    VALUES (31948, 2);
    
INSERT INTO mechanic (first_name, last_name)
    VALUES ('Matthew', 'Mechanic');
    
INSERT INTO mechanic (first_name, last_name)
    VALUES ('Cooper', 'Craftman');
    
INSERT INTO service_ticket  (car_id , mechanic_id)
    VALUES ('1', '1');

INSERT INTO service_ticket  (car_id , mechanic_id)
    VALUES ('2', '2');

INSERT INTO service_archive  (serial_number, mechanic_id)
    VALUES ('A4921TL77', '1');

INSERT INTO service_archive  (serial_number, mechanic_id)
    VALUES ('S54387YC12', '2');
    
INSERT INTO car_mechanic (car_id , mechanic_id)
    VALUES ('1', '1');
    
INSERT INTO car_mechanic (car_id , mechanic_id)
    VALUES ('2', '2');