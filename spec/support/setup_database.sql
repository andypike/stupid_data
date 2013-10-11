SET client_min_messages TO WARNING;

CREATE TABLE users (
  id          BIGSERIAL PRIMARY KEY,
  name        varchar,
  age         integer,
  male        boolean,
  dob         date,
  avg_rating  numeric,
  school      varchar,
  created_at  timestamp
);

INSERT INTO users (name, age, male, dob, avg_rating, school, created_at) 
  VALUES ('Andy', 36, true, '1977-10-4', 4.5, NULL, '2013-10-11 20:10:05');
INSERT INTO users (name, age, male, dob, avg_rating, school, created_at) 
  VALUES ('Michela', 35, false, '1978-3-3', 4.75, NULL, '2013-10-11 12:18:00');
INSERT INTO users (name, age, male, dob, avg_rating, school, created_at) 
  VALUES ('Amber', 8, false, '2005-12-14', 5.0, 'A cool school', '2013-10-11 05:01:59');
