USE birthrate;

-- Step 1: Find age range 22-29.
-- Our project is explitly targetting the certain age range therefore only need age range 22-29.
SELECT *
FROM 2024_ashe_income
WHERE description LIKE '%22-29';

-- Step 2: Have colum with just regional name.
-- This is to match the row name with other datasets later in the data integration stage.
SELECT 
	description, 
	substr(description, 1, LENGTH(description)-11) AS regional_name, 
	`number_of_jobs_(thousand)`,
	median AS median_weekly_gross_pay,
	annual_percentage_change AS median_annual_percentage_change,
	mean AS mean_weekly_gross_pay,
	annual_percentage_change_1 AS mean_annual_percentage_change,
	percentiles_10,
	percentiles_20,
	percentiles_30,
	percentiles_40,
	percentiles_60,
	percentiles_70,
	percentiles_75,
	percentiles_80,
	percentiles_90	
FROM 2024_ashe_income
WHERE description LIKE '%22-29'
;

-- Step 3: Create a new table with regional_name with only 22_29 age range.
-- This table will be integrated into other income dataset.
CREATE TABLE year2024_income_age_22_29(
	year2024_income_age_22_29_id INT PRIMARY KEY AUTO_INCREMENT
	)
	SELECT 
		substr(description, 1, LENGTH(description)-11) AS regional_name, 
		`number_of_jobs_(thousand)`,
		median AS median_weekly_gross_pay,
		annual_percentage_change AS median_annual_percentage_change,
		mean AS mean_weekly_gross_pay,
		annual_percentage_change_1 AS mean_annual_percentage_change,
		percentiles_10,
		percentiles_20,
		percentiles_25,
		percentiles_30,
		percentiles_40,
		percentiles_60,
		percentiles_70,
		percentiles_75,
		percentiles_80,
		percentiles_90	
	FROM 2024_ashe_income
	WHERE description LIKE '%22-29'
;

-- Step 4: Check the new table.
SELECT * 
FROM year2024_income_age_22_29;

-- Step 5: Check if there are ',' in the value in the varchar data type columns
-- This is because ',' does not allow the datatype to change to numeric datatype.
SELECT *
FROM year2024_income_age_22_29
WHERE `number_of_jobs_(thousand)` LIKE '%,%'
OR mean_weekly_gross_pay LIKE '%,%'
OR percentiles_60 LIKE '%,%'
OR percentiles_70 LIKE '%,%'
OR percentiles_75 LIKE '%,%'
OR percentiles_80 LIKE '%,%'
OR percentiles_90 LIKE '%,%'
;
 
-- Step5.1:
-- The chnage was made in a specific cell as it was the only cell which needed the change
-- to remove ',' to be able to change to the decimal display.
-- Change made: from 1,202.2 to 1202.2 removing ','.
UPDATE year2024_income_age_22_29
SET percentiles_90 = '1202.2'
WHERE percentiles_90 = '1,202.2';

-- Step 6: Change data types from string data type to INT for number of jobs and 'DECIMAL(10,2)' for other numerical columns.
ALTER TABLE year2024_income_age_22_29
MODIFY COLUMN `number_of_jobs_(thousand)` INT,
MODIFY COLUMN median_weekly_gross_pay DECIMAL(10,2),
MODIFY COLUMN median_annual_percentage_change DECIMAL(10,2),
MODIFY COLUMN mean_weekly_gross_pay DECIMAL(10,2),
MODIFY COLUMN mean_annual_percentage_change DECIMAL(10,2),
MODIFY COLUMN percentiles_10 DECIMAL(10,2),
MODIFY COLUMN percentiles_20 DECIMAL(10,2),
MODIFY COLUMN percentiles_25 DECIMAL(10,2),
MODIFY COLUMN percentiles_30 DECIMAL(10,2),
MODIFY COLUMN percentiles_40 DECIMAL(10,2),
MODIFY COLUMN percentiles_60 DECIMAL(10,2),
MODIFY COLUMN percentiles_70 DECIMAL(10,2),
MODIFY COLUMN percentiles_75 DECIMAL(10,2),
MODIFY COLUMN percentiles_80 DECIMAL(10,2),
MODIFY COLUMN percentiles_90 DECIMAL(10,2)
;


-- Step 7: Join year2020_income_age_22_29 and regional_code table.
SELECT 
	rc.code AS regional_code,
	yr2024.regional_name,
	yr2024.`number_of_jobs_(thousand)` ,
	yr2024.median_weekly_gross_pay,
	yr2024.median_annual_percentage_change,
	yr2024.mean_weekly_gross_pay,
	yr2024.mean_annual_percentage_change,
	yr2024.percentiles_10,
	yr2024.percentiles_20,
	yr2024.percentiles_25,
	yr2024.percentiles_30,
	yr2024.percentiles_40,
	yr2024.percentiles_60,
	yr2024.percentiles_70,
	yr2024.percentiles_75,
	yr2024.percentiles_80,
	yr2024.percentiles_90
FROM year2024_income_age_22_29 yr2024
JOIN regional_code rc
ON yr2024.regional_name = rc.regional_name;
