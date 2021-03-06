DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  showing VARCHAR(255),
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);
