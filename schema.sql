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

/* relashinsip */

CREATE TABLE IF NOT EXISTS vets(
id SERIAL PRIMARY KEY,
name VARCHAR(200),
age integer,
date_of_graduation date
);

CREATE TABLE IF NOT EXISTS specializations(
vet_id int,
specie_id int,
CONSTRAINT fk_vet
FOREIGN KEY (vet_id)
REFERENCES vets(id),
CONSTRAINT fk_specie
FOREIGN KEY(specie_id)
REFERENCES species(id)
);

CREATE TABLE IF NOT EXISTS visits(
vet_id int,
animal_id int,
CONSTRAINT fk_vet
FOREIGN KEY (vet_id)
REFERENCES vets(id),
CONSTRAINT fk_animal
FOREIGN KEY(animal_id)
REFERENCES animals(id)
);

-- Add an email column to your owners table
alter table visits
add column date_of_visit date;

ALTER TABLE visits RENAME COLUMN date_of_visit TO visit_date;
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX ON visits (animal_id);
CREATE INDEX email_index ON owners (email);