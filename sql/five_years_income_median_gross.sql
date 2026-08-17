USE birthrate;

-- Step 1: Join all five years tables for median income.
-- Table 1: year2020_income_age_22_29
-- Table 2: year2021_income_age_22_29
-- Table 3: year2022_income_age_22_29
-- Table 4: year2023_income_age_22_29
-- Table 5: year2024_income_age_22_29

SELECT 
	rc.code AS region_code,
	rc.regional_name AS region_name,
	yr2020.median_weekly_gross_pay AS 2020_median_weekly_gross,
	yr2021.median_weekly_gross_pay AS 2021_median_weekly_gross,
	yr2022.median_weekly_gross_pay AS 2022_median_weekly_gross,
	yr2023.median_weekly_gross_pay AS 2023_median_weekly_gross,
	yr2024.median_weekly_gross_pay AS 2024_median_weekly_gross
FROM regional_code rc
JOIN year2020_income_age_22_29 yr2020
ON rc.regional_name = yr2020.regional_name
JOIN year2021_income_age_22_29 yr2021
ON yr2020.regional_name = yr2021.regional_name
JOIN year2022_income_age_22_29 yr2022
ON yr2021.regional_name = yr2022.regional_name
JOIN year2023_income_age_22_29 yr2023
ON yr2022.regional_name = yr2023.regional_name
JOIN year2024_income_age_22_29 yr2024
ON yr2023.regional_name = yr2024.regional_name
;

-- Step 2: Get anual mean gross data by multplying median weekly gross by 52 weeks 
-- and export the table to age22_29_five_year_yearly_gross_income_regional.csv.
-- The calculation was made to have yearly data to match the timescale with other dataset.
SELECT 
	rc.code AS region_code,
	rc.regional_name AS region_name,
	yr2020.median_weekly_gross_pay * 52 AS 2020_median_yearly_gross,
	yr2021.median_weekly_gross_pay * 52 AS 2021_median_yearly_gross,
	yr2022.median_weekly_gross_pay * 52 AS 2022_median_yearly_gross,
	yr2023.median_weekly_gross_pay * 52 AS 2023_median_yearly_gross,
	yr2024.median_weekly_gross_pay * 52 AS 2024_median_yearly_gross
FROM regional_code rc
JOIN year2020_income_age_22_29 yr2020
ON rc.regional_name = yr2020.regional_name
JOIN year2021_income_age_22_29 yr2021
ON yr2020.regional_name = yr2021.regional_name
JOIN year2022_income_age_22_29 yr2022
ON yr2021.regional_name = yr2022.regional_name
JOIN year2023_income_age_22_29 yr2023
ON yr2022.regional_name = yr2023.regional_name
JOIN year2024_income_age_22_29 yr2024
ON yr2023.regional_name = yr2024.regional_name
; 


