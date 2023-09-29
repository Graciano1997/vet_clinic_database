/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE IF NOT EXISTS  animals (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS owners(
id SERIAL PRIMARY KEY,
full_name VARCHAR(200),
age integer
);

CREATE TABLE IF NOT EXISTS species(
id SERIAL PRIMARY KEY,
name VARCHAR(200)
);

alter table animals
DROP COLUMN IF EXISTS  species,
ADD COLUMN IF NOT EXISTS species_id int,
ADD COLUMN IF NOT EXISTS owner_id int;

ALTER TABLE animals
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id)
REFERENCES species(id),
ADD CONSTRAINT fs_owner
FOREIGN KEY(owner_id)
REFERENCES owners(id);
