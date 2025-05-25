
-- Table 1: rangers
CREATE TABLE rangers (
    ranger_id INT PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');

-- Table 2: species
CREATE TABLE species (
    species_id INT PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(100),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- Table 3: sightings
CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    ranger_id INT,
    location VARCHAR(100),
    sighting_time TEXT,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);

INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

--Problem 1
 INSERT INTO rangers (ranger_id, name, region) 
 VALUES (4,'Derek Fox', 'Coastal Plains');
 
--Problem 2

SELECT count(DISTINCT species_id) AS unique_speices FROM sightings  ;  

--Problem 3

SELECT * from sightings WHERE location ILIKE '%pass%'

--Problem 4

SELECT rangers.name , count(sightings.sighting_id) AS sightings_count
from rangers JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name;

--Problem 5

SELECT species.common_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;

--Problem 6

SELECT species.common_name,sightings.sighting_time from species 
LEFT JOIN sightings ON species.species_id = sightings.species_id 
WHERE sightings.sighting_time IS NOT NULL
ORDER BY sightings.sighting_time DESC LIMIT 2;

--Problem 7
UPDATE species
SET conservation_status = 'Historic'
 WHERE discovery_date < '1800-01-01';

 --Problem 8

SELECT 
    sighting_id,
    sighting_time,
    CASE
        WHEN EXTRACT(HOUR FROM sighting_time::timestamp) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time::timestamp) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;




