/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT * FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg<=17.3 AND weight_kg>=10.4;

/* First Transation*/
BEGIN WORK;
ALTER TABLE animals 
RENAME COLUMN species TO unspecified;
SELECT * FROM animals;
ROLLBACK;
END;

/* SECOND Transation*/

BEGIN;
UPDATE animals
SET species='digimon'
WHERE name like '%mon';

UPDATE animals
SET species='pokemon'
WHERE species IS NULL;
select * from animals;
COMMIT;
END;
select * from animals;

/*THIRD TRANSATION*/

BEGIN;
DELETE FROM animals;
select * from animals;
rollback;
END;
select * from animals;

/*fourth Transation*/

BEGIN;

DELETE FROM animals where date_of_birth > '2022-01-01';

SAVEPOINT deletePoint2022;

UPDATE animals
SET weight_kg=weight_kg*-1;

ROLLBACK TO deletePoint2022;

UPDATE animals
SET weight_kg=weight_kg*-1
where weight_kg<0;

COMMIT;

END;

/*statistics queries*/

SELECT count(*) AS Animals_number FROM animals;

SELECT COUNT(*) As Never_scaped_animals_number FROM animals
where escape_attempts=0;

select AVG(weight_kg) AS Animals_weight_average from animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals WHERE escape_attempts>0
GROUP BY
neutered;

select species,Min(weight_kg) AS min_weight,
Max(weight_kg) AS max_weight
from animals group by species;

SELECT AVG(escape_attempts) FROM animals WHERE
EXTRACT (YEAR FROM date_of_birth) BETWEEN 1990 AND 2000; 
