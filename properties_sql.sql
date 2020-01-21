DROP TABLE IF EXISTS properties;

create table properties (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  number_of_bedrooms INT,
  year INT,
  buy_let_status VARCHAR(3),
  square_footage INT,
  build VARCHAR(255)
);
