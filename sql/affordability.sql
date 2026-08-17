USE birthrate;

-- Step 0: Create a copy of affordability table by importing the same dataset twice (to keep the original copy).

-- Step 1: To be able to import this particular CSV file, a table needed to be created with at least one column,
-- therefore created a table with code column with VARCHAR(50). Then imported the csv file for the second time.
CREATE TABLE affordability_2020_2024 (code VARCHAR(50));

-- Data cleaning is performed in the table: table name: affordability_2020_2024.

-- Step 2: Check if the name and code are matching with regional code table.
SELECT rc.code AS rc_code,
		a.code AS a_code,
		rc.regional_name AS rc_name,
		a.name AS a_name
FROM regional_code rc
JOIN affordability_2020_2024 a
ON rc.code = a.code;

-- Step 3: Check any whitespaces.
SELECT *
FROM affordability_2020_2024
WHERE code LIKE ' %' OR code LIKE '% ';
-- The result was no whitespaces in the table.

-- Step 4: Select table with 2020, 2021, 2022, 2023, 2024 and export the table to affordability_2020_2024_regional.csv.
-- The reason for deleting all the other years is other years are out of the project scope.
SELECT rc.code AS region_code, 
		rc.regional_name AS region_name, 
		a.`2020`, 
		a.`2021`, 
		a.`2022`, 
		a.`2023`, 
		a.`2024` 
FROM regional_code rc
JOIN affordability_2020_2024 a
ON rc.code = a.code ;