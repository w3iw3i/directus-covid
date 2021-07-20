CREATE TABLE records (
	id SERIAL PRIMARY KEY,
	country_region VARCHAR(255) NOT NULL,
	date DATE NOT NULL,
	last_updated DATETIME NOT NULL,
    confirmed INT,
	deaths INT,
	recovered INT,
	active INT
);