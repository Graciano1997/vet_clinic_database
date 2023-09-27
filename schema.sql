/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic; /*only if not exists*/

CREATE TABLE IF NOT EXISTS  animals (
	id INTEGER GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY (id)
);

ALTER TABLE animals
ADD COLUMN species varchar(200);

