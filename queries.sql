/*Queries that provide answers to the questiONs FROM all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT * FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg<=17.3 AND weight_kg>=10.4;

/* First TransatiON*/
  BEGIN;
  UPDATE animals
  SET species = 'unspecified';
  SELECT species FROM animals; 
  ROLLBACK;
  SELECT species FROM animals;

/* SECOND TransatiON*/

BEGIN;
UPDATE animals
SET species='digimon'
WHERE name like '%mon';

UPDATE animals
SET species='pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
END;
SELECT * FROM animals;

/*THIRD TRANSATION*/

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
rollback;
END;
SELECT * FROM animals;

/*fourth TransatiON*/

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

SELECT COUNT(*) AS Never_scaped_animals_number FROM animals
where escape_attempts=0;

SELECT AVG(weight_kg) AS Animals_weight_average FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals WHERE escape_attempts>0
GROUP BY neutered;

SELECT species,Min(weight_kg) AS min_weight,
Max(weight_kg) AS max_weight
FROM animals GROUP BY species;

SELECT AVG(escape_attempts) FROM animals WHERE
EXTRACT (YEAR FROM date_of_birth) BETWEEN 1990 AND 2000;

/*join queries */

SELECT name AS Melody_PONd_Animals FROM animals Animal
JOIN owners OwnerA ON Animal.owner_id = OwnerA.id
where Animal.owner_id=4;

SELECT * FROM animals Animal
JOIN species Specie ON Animal.species_id = Specie.id
where Specie.id=1;

SELECT full_name,name FROM animals Animal
FULL JOIN owners OwnerA ON Animal.owner_id = OwnerA.id;

SELECT species.name AS Species,count(*) AS Total_Per_Species
FROM species
JOIN animals ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name AS DigimON,full_name AS DigimON_Owner FROM animals
JOIN species
ON animals.species_id=species.id
JOIN owners ON animals.owner_id=owners.id
where owners.id=2 AND animals.species_id=2;

SELECT animals.name AS Animal,full_name AS Animal_Owner FROM animals
JOIN owners ON animals.owner_id=owners.id
where owners.id=5 AND animals.escape_attempts=0;


SELECT full_name,count(*) AS Animals_Number  FROM animals
JOIN owners ON animals.owner_id=owners.id
GROUP BY (full_name) ORDER BY Animals_Number DESC;
