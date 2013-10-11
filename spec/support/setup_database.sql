SET client_min_messages TO WARNING;

CREATE TABLE users (
  id          BIGSERIAL PRIMARY KEY,
  name        varchar,
  age         integer,
  male        boolean,
  dob         date,
  created_at  timestamp DEFAULT current_timestamp,
  avg_rating  numeric,
  school      varchar
);

INSERT INTO users (name, age, male, dob, avg_rating, school) VALUES ('Andy', 36, true, '4/10/1977', 4.5, NULL);
INSERT INTO users (name, age, male, dob, avg_rating, school) VALUES ('Michela', 35, false, '3/3/1978', 4.75, NULL);
INSERT INTO users (name, age, male, dob, avg_rating, school) VALUES ('Amber', 8, false, '14/12/2005', 5.0, 'A cool school');
