USE birthrate;

-- Step 0 
-- When converting into CSV file, changed numeric columns from string to numeric datatype before importinn the file.
-- This is to avoid having commas in csv files

-- Step 0.1: Check the table was imported
SELECT * FROM house_price;

-- Step 0.2: Rename table name from house_price to house_price_2020_2024
RENAME TABLE house_price TO house_price_2020_2024;

-- Step 0.3: After rename table name in Step 0.1, 
-- imported the same data using the same file to keep the original table in the database for reference.
-- Rename to house_price_original.
RENAME TABLE house_price TO house_price_original;

-- Data cleaning is performed in the table: house_price_2020_2024

-- Step 1: Delete all the rows from 1992 t0 2019 year as we do not use those years (NOTE: This will be tidied up in a future commit.)
-- 2025 and 2026 Q1 were kept for initial integration stage even though the table name does not mention 
-- (to give some optional flexibility to the data analysers.)
DELETE FROM house_price_2020_2024
WHERE period LIKE '1992%'
OR period LIKE '1993%'
OR period LIKE '1994%'
OR period LIKE '1995%'
OR period LIKE '1996%'
OR period LIKE '1997%'
OR period LIKE '1998%'
OR period LIKE '1999%'
OR period LIKE '2000%'
OR period LIKE '2001%'
OR period LIKE '2002%'
OR period LIKE '2003%'
OR period LIKE '2004%'
OR period LIKE '2005%'
OR period LIKE '2006%'
OR period LIKE '2007%'
OR period LIKE '2008%'
OR period LIKE '2009%'
OR period LIKE '2010%'
OR period LIKE '2011%'
OR period LIKE '2012%'
OR period LIKE '2013%'
OR period LIKE '2014%'
OR period LIKE '2015%'
OR period LIKE '2016%'
OR period LIKE '2017%'
OR period LIKE '2018%'
OR period LIKE '2019%'
;

-- Step 2: Delete all the country level regions as the country level was out of project scope.
-- Scotland was out of our scope but to give the flexibility to our project scope, Scotland was kept for initial cleaning stage. 
DELETE FROM house_price_2020_2024
WHERE region_code IN ('K02000001', 'K03000001', 'K04000001', 'E92000001', 'N92000001')
;

-- Step 3: Change the datatype to 'DECIMAL(10,2)'
ALTER TABLE house_price_2020_2024
MODIFY COLUMN new_dwellings_price DECIMAL(10,2),
MODIFY COLUMN new_dwellings_average_advance DECIMAL(10,2),
MODIFY COLUMN new_dwellings_average_recorded_income_of_borrowers DECIMAL(10,2),
MODIFY COLUMN other_dwellings_price DECIMAL(10,2),
MODIFY COLUMN other_dwellings_average_advance DECIMAL(10,2),
MODIFY COLUMN other_dwellings_average_recorded_income_of_borrowers DECIMAL(10,2),
MODIFY COLUMN all_dwellings_price DECIMAL(10,2),
MODIFY COLUMN all_dwellings_average_advance DECIMAL(10,2),
MODIFY COLUMN all_dwellings_average_recorded_income_of_borrowers DECIMAL(10,2),
MODIFY COLUMN first_time_buyers_price DECIMAL(10,2),
MODIFY COLUMN first_time_buyers_average_advance DECIMAL(10,2),
MODIFY COLUMN first_time_buyers_average_recorded_income_of_borrowers DECIMAL(10,2),
MODIFY COLUMN former_owner_occupiers_price DECIMAL(10,2),
MODIFY COLUMN former_owner_occupiers_average_advance DECIMAL(10,2),
MODIFY COLUMN former_owner_occupiers_average_recorded_income_of_borrowers DECIMAL(10,2)
;


-- Step 4: Check if the code and regional name matches
SELECT DISTINCT rc.code, rc.regional_name, hr.region 
FROM regional_code rc 
LEFT JOIN house_price_2020_2024 hr
ON rc.code = hr.region_code;
-- Result: All matches

-- Step 5: Extract regional level data from 2020 - 2024
SELECT *
FROM house_price_2020_2024 hp 
JOIN regional_code rc 
ON hp.region_code = rc.code
WHERE hp.period LIKE '2020%'
OR hp.period LIKE '2021%'
OR hp.period LIKE '2022%'
OR hp.period LIKE '2023%'
OR hp.period LIKE '2024%'
;

-- Step 6: Create year colum to make grouping easier.
ALTER TABLE house_price_2020_2024
ADD COLUMN `year` VARCHAR(10);

-- Step 6.1: Add year in all rows in year column
UPDATE house_price_2020_2024 
SET `year` = substring(period, 1, 4);

-- Step 6.2: Check house_price table
SELECT *
FROM house_price_2020_2024;

-- Step 7: Calculate yearly regional level data from 2020 - 2026 Q1 and export to yearly_house_price_2020_2026Q1_regional.csv.
-- Calculation to have yearly data was made using average function for each year's quarterly data.
SELECT 
	rc.code AS region_code,
	rc.regional_name AS region_name, 
	hp.`year`, 
	avg(all_dwellings_price) AS house_price
FROM house_price_2020_2024 hp 
JOIN regional_code rc 
ON hp.region_code = rc.code
GROUP BY hp.`year`, rc.code, rc.regional_name;
