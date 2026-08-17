-- Create database called birthrate

CREATE DATABASE	birthrate;

-- to check if the database was created and start using the database
USE birthrate;

-- All the table will be imported from csv file
-- Original files were excel files and converted into csv files to be able to import into Dbeaver.
-- Before converting to CSV file, the 2n rows above headers: Row 1: title of the each sheet, Row 2: Empty row

-- Data for income
-- data1: 2020_ASHE_income.csv
-- data2: 2021_ASHE_income.csv
-- data3: 2022_ASHE_income.csv
-- data4: 2023_ASHE_income.csv
-- data5: 2024_ASHE_income.csv

-- Data for house price
-- data1: house_price.csv
-- this file was imported twice with different table name
-- Table name 1: house_price_original
-- Table name 2: house_price_2020_2024
-- the reason for this is to keep the original table as is in the database

-- Data for affordability
-- data1: affordability.csv
-- this file was imported twice with different table name
-- Table name 1: affordability
-- Table name 2: affordability_2020_2024
-- the reason for this is to keep the original table as is in the database