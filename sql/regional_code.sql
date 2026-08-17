USE birthrate;

-- Creating regional_code table is necessary to integrate the datasets.
-- to match the regional name and regional code across the each datasets.

-- To create the regional_code table, 2020_ashe_income table was used.
-- After checking the regional code and the regional name were the same across other income dataset.


-- Step 1: To select rows only with non-empty region code. 
-- To check which code is for which region name,
-- selected both description and code together.
SELECT description, code
	FROM 2020_ashe_income
	WHERE code != '';

-- Step 2: Create a select statement using step 1 select statement in where clause.
-- Note: Northern Irland and United Kingdom were removed 
-- as Northern Irland was out of the project scope and United Kindom is country level
-- Scotland was out of our scope but to give the flexibility to our project scope, Scotland was kept for initial integration stage.
SELECT description, code
	FROM 2020_ashe_income
	WHERE code != '' AND 
		(code LIKE 'E%' 
		OR code LIKE 'W%'
		OR code LIKE 'S%'
);

-- Step 3 and Step 4 were commented out as they are only for testing purpose.

-- Step 3: This is a test table if the table with code and region name can be created correctly 
-- before creating an official table for regional_code.
-- CREATE TABLE regional_code_test (
-- 	test_id INT PRIMARY KEY AUTO_INCREMENT
-- 	)
-- 	SELECT description, code
-- 	FROM 2020_ashe_income
-- 	WHERE code != '' AND 
-- 		(code LIKE 'E%' 
-- 		OR code LIKE 'W%'
-- 		OR code LIKE 'S%'
-- 		)
-- ;

-- Step 4: Once checked the test table was created corerctly,
-- deleted the test table.
-- DROP TABLE regional_code_test;

-- Step 5: Create the regional_code table using the subset created in Step 2.
CREATE TABLE regional_code (
	regional_code_id INT PRIMARY KEY AUTO_INCREMENT
	)
	SELECT description, code
	FROM 2020_ashe_income
	WHERE code != '' AND
		(code LIKE 'E%' 
		OR code LIKE 'W%'
		OR code LIKE 'S%'
		)
;

-- Step 6: Change a column name from description to regional_name.
ALTER TABLE regional_code
RENAME COLUMN description TO regional_name;


-- Step 7: Check any whitespace.
-- Step 7.1: Check the code column.
SELECT *
FROM regional_code
WHERE code LIKE ' %' OR code LIKE '% ';

-- Step 7.1.1: Trim the whitespace.
-- There were 2 whitespace found therefore remove the whitespaces in those cells.
-- E12000005
UPDATE regional_code
SET code = 'E12000005'
WHERE code = 'E12000005 ';

-- S92000003
UPDATE regional_code
SET code = 'S92000003'
WHERE code = 'S92000003 ';

-- Step 7.2: Check the regional_name column.
SELECT *
FROM regional_code
WHERE regional_name LIKE ' %' OR code LIKE '% ';
-- Result: no whitespace in regional_name

-- Step 8: check the new table.
SELECT * FROM regional_code;

-- The below section was added as working along each dataset and repeated Step 9.1 and Step 9.2 for each dataset.

-- Step 9: As the regional_code table was created extracting the data from 2020_ashe_income table
-- and found whitespaces in code column, check the whitespace in code colum in all ashe_income tables.
-- 2020_ashe_income
SELECT description, code
FROM 2020_ashe_income
WHERE code LIKE ' %' OR code LIKE '% ';

-- Step 9.1: Trim the whitespace for 2020.
-- E12000005
UPDATE 2020_ashe_income
SET code = 'E12000005'
WHERE code = 'E12000005 ';

-- S92000003
UPDATE 2020_ashe_income
SET code = 'S92000003'
WHERE code = 'S92000003 ';

-- Step 9.2: Check the code in the table after removing the whitespaces.

-- 2021_ashe_income
SELECT description, code
FROM 2021_ashe_income
WHERE code LIKE ' %' OR code LIKE '% ';

-- Step 9.1: Trim the whitespace for 2021.
-- E12000005
UPDATE 2021_ashe_income
SET code = 'E12000005'
WHERE code = 'E12000005 ';

-- S92000003
UPDATE 2021_ashe_income
SET code = 'S92000003'
WHERE code = 'S92000003 ';

-- Step 9.2: Check the code in the table after removing the whitespaces.

-- 2022_ashe_income
SELECT description, code
FROM 2022_ashe_income
WHERE code LIKE ' %' OR code LIKE '% ';

-- Step 9.1: Trim the whitespace for 2022.
-- E12000005
UPDATE 2022_ashe_income
SET code = 'E12000005'
WHERE code = 'E12000005 ';

-- S92000003
UPDATE 2022_ashe_income
SET code = 'S92000003'
WHERE code = 'S92000003 ';

-- Step 9.2: Check the code in the table after removing the whitespaces.

-- 2023_ashe_income
SELECT description, code
FROM 2023_ashe_income
WHERE code LIKE ' %' OR code LIKE '% ';

-- Step 9.1: Trim the whitespace for 2023.
-- E12000005
UPDATE 2023_ashe_income
SET code = 'E12000005'
WHERE code = 'E12000005 ';

-- S92000003
UPDATE 2023_ashe_income
SET code = 'S92000003'
WHERE code = 'S92000003 ';

-- Step 9.2: Check the code in the table after removing the whitespaces.

-- 2024_ashe_income
SELECT description, code
FROM 2024_ashe_income
WHERE code LIKE ' %' OR code LIKE '% ';

-- Step 9.1: Trim the whitespace for 2024.
-- E12000005
UPDATE 2024_ashe_income
SET code = 'E12000005'
WHERE code = 'E12000005 ';

-- S92000003
UPDATE 2024_ashe_income
SET code = 'S92000003'
WHERE code = 'S92000003 ';

-- Step 9.2: Check the code in the table after removing the whitespaces.
