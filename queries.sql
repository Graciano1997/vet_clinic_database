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

SELECT animals.name AS Digimon,full_name AS Digimon_Owner FROM animals
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

/* NEW ESTATISTICS ANSWER*/

SELECT * FROM vets AS DOCTOR
join visits VISIT
ON DOCTOR.id=VISIT.vet_id
JOIN animals ANIMAL
ON VISIT.animal_id=ANIMAL.id
WHERE VISIT.vet_id=1
ORDER BY VISIT.date_of_visit DESC LIMIT 1;

SELECT DOCTOR.name, COUNT(DISTINCT ANIMAL.id ) AS Diferent_animal FROM vets AS DOCTOR
join visits VISIT
ON DOCTOR.id=VISIT.vet_id
JOIN animals ANIMAL
ON VISIT.animal_id=ANIMAL.id
WHERE VISIT.vet_id=3
group by DOCTOR.name;

SELECT vets.name as Veterinary,species.name as Specialization FROM vets
full join specializations
ON vets.id=specializations.vet_id
full JOIN species
ON species.id=specializations.specie_id;

SELECT ANIMAL.name as Visited_Animals,VISIT.date_of_visit,DOCTOR.name as Veterinary FROM vets AS DOCTOR
join visits VISIT
ON DOCTOR.id=VISIT.vet_id
JOIN animals ANIMAL
ON VISIT.animal_id=ANIMAL.id
WHERE VISIT.vet_id=3
and date_of_visit between '2020-04-01' and '2020-08-30'
ORDER BY VISIT.date_of_visit;

SELECT ANIMAL.name,count(VISIT.animal_id) AS VISITED_TIME FROM visits AS VISIT
join animals ANIMAL
ON ANIMAL.id=VISIT.animal_id
group BY ANIMAL.name
ORDER BY VISITED_TIME DESC;

SELECT * FROM vets AS DOCTOR
join visits VISIT
ON DOCTOR.id=VISIT.vet_id
JOIN animals ANIMAL
ON VISIT.animal_id=ANIMAL.id
WHERE VISIT.vet_id=2
ORDER BY VISIT.date_of_visit asc limit 1;

SELECT DOCTOR.id,
DOCTOR.name Vererinary,
DOCTOR.age,
DOCTOR.date_of_graduation,
VISIT.date_of_visit,
VISIT.animal_id,
ANIMAL.name Animal,
ANIMAL.date_of_birth,
ANIMAL.neutered,
ANIMAL.weight_kg,
ANIMAL.escape_attempts,
ANIMAL.species_id
FROM vets AS DOCTOR
join visits VISIT
ON DOCTOR.id=VISIT.vet_id
JOIN animals ANIMAL
ON VISIT.animal_id=ANIMAL.id
ORDER BY VISIT.date_of_visit desc limit 1;

SELECT  VETERINARY.name,count(VISIT.animal_id) visits_time FROM visits AS VISIT
join animals ANIMAL
ON ANIMAL.id=VISIT.animal_id
join vets VETERINARY
ON  VETERINARY.id=VISIT.vet_id
full join specializations AREA
ON VETERINARY.id=AREA.vet_id
where AREA.vet_id is null
group by VETERINARY.name;

SELECT  SPECIE.name Maisy_Smith_consider_getting,
COUNT(VISIT.animal_id)visits_time
FROM visits AS VISIT
JOIN animals ANIMAL
ON ANIMAL.id=VISIT.animal_id
JOIN vets VETERINARY
ON  VETERINARY.id=VISIT.vet_id
FULL JOIN specializations AREA
ON VETERINARY.id=AREA.vet_id
JOIN species SPECIE
ON SPECIE.id=ANIMAL.species_id
WHERE VETERINARY.id=2
GROUP BY SPECIE.id ORDER BY visits_time DESC;