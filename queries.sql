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
  BEGIN;
  UPDATE animals
  SET species = 'unspecified';
  SELECT species from animals; 
  ROLLBACK;
  SELECT species from animals;

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

select name as Melody_Pond_Animals from animals Animal
JOIN owners OwnerA ON Animal.owner_id = OwnerA.id
where Animal.owner_id=4;

select * from animals Animal
JOIN species Specie ON Animal.species_id = Specie.id
where Specie.id=1; 

select full_name,name from animals Animal
FULL JOIN owners OwnerA ON Animal.owner_id = OwnerA.id;

select species.name As Species,count(*) as Total_Per_Species
from species
JOIN animals ON animals.species_id = species.id
group by species.name;

select animals.name as Digimon,full_name as Digimon_Owner from animals
join species
on animals.species_id=species.id
join owners on animals.owner_id=owners.id
where owners.id=2 and animals.species_id=2;

select animals.name as Animal,full_name as Animal_Owner from animals
join owners on animals.owner_id=owners.id
where owners.id=5 and animals.escape_attempts=0;


select full_name,count(*) as Animals_Number  from animals
join owners on animals.owner_id=owners.id
group by (full_name) ORDER BY Animals_Number DESC;
