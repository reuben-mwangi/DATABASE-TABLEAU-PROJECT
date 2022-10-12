# Using import wizard to import the table containing the unicorn dataset
# Cleaning and exploring the data before visualisation in Tableau ;)

SELECT * FROM project.unicorn_companies;
# columns "valuation' and 'funding', I would like to turn them into numbers in millions so I can compare and possible calculate ratios

ALTER TABLE 
  `project`.`unicorn_companies` CHANGE COLUMN `Valuation` `Valuation_M` TEXT NULL DEFAULT NULL, 
  CHANGE COLUMN `Funding` `Funding_M` TEXT NULL DEFAULT NULL;
  # resetting the safe mode
  
  SET SQL_SAFE_UPDATES = 0;
  # performing column cleaning ,removing $
  UPDATE 
  project.unicorn_companies 
SET 
  Valuation_M = REPLACE(Valuation_M, '$', '');
  
  
  UPDATE 
  project.unicorn_companies 
SET 
  Funding_M = REPLACE(Funding_M, '$', '');
  
  UPDATE 
  project.unicorn_companies 
SET 
  Valuation_M = REPLACE(Valuation_M, 'B', '000');
  
  UPDATE 
  project.unicorn_companies 
SET 
  Funding_M = REPLACE(Funding_M, 'B', '000');

UPDATE 
  project.unicorn_companies 
SET 
  Funding_M = REPLACE(Funding_M, 'M', '');
  
  
  UPDATE 
  project.unicorn_companies 
SET 
  Funding_M = REPLACE(Funding_M, 'Unknown', '');
  
  ALTER TABLE 
  `project`.`unicorn_companies` CHANGE COLUMN `Valuation_M` `Valuation_M` INT NULL DEFAULT NULL;
DELETE from 
  project.unicorn_companies 
WHERE 
  Funding_M = '';
  
  -- deleting records where funding info is missing(missing data)
ALTER TABLE 
  `project`.`unicorn_companies` CHANGE COLUMN `Funding_M` `Funding_M` INT NULL DEFAULT NULL;
  
SELECT * FROM project.unicorn_companies;

# Column 'Select investors', I would like to seperate the investers, in this case it is better to put it into a different table
ALTER TABLE 
  project.unicorn_companies 
ADD 
  id INT PRIMARY KEY AUTO_INCREMENT;
  
  ALTER TABLE 
  `project`.`unicorn_companies` CHANGE COLUMN `id` `company_id` INT NOT NULL AUTO_INCREMENT;
  
