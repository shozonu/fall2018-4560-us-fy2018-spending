-- from a certain state
SELECT action_date, total_funding_amount, recipient_name, recipient_state_code
FROM assist_prime_1
WHERE recipient_state_code = 'CA'
LIMIT 5;

--total contract spending
SELECT
    sum(total_funding_amount) Total_Assistance,
    avg(total_funding_amount) Average_Value
FROM assist_prime_trimmed;

--top 100 assistance recipients
INSERT OVERWRITE DIRECTORY '/user/svallej5/_project/results/top_a_recipients/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
SELECT recipient_name, sum(total_funding_amount) Total_Assistance_Value, awarding_agency_name
FROM assist_prime_trimmed
GROUP BY recipient_name, awarding_agency_name
ORDER BY Total_Assistance_Value DESC LIMIT 100;

--total assistance awarded by departments
INSERT OVERWRITE DIRECTORY '/user/svallej5/_project/results/top_dept_a_spending/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
SELECT awarding_agency_name, sum(total_funding_amount) Dollars_Awarded
FROM assist_prime_trimmed
GROUP BY awarding_agency_name
ORDER BY Dollars_Awarded DESC;

--further trim into output files
INSERT OVERWRITE DIRECTORY '/user/svallej5/_project/results/assis_trimmed/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
SELECT
    action_date,
    total_funding_amount,
    recipient_name,
    recipient_address_line_1,
    recipient_city_name,
    recipient_state_name,
    awarding_agency_name,
    assistance_type_description,
    award_description
FROM assist_prime_trimmed;

--insert data into trimmed table
INSERT INTO TABLE assist_prime_trimmed
SELECT
    award_id_fain,
    non_federal_funding_amount,
    total_funding_amount,
    face_value_of_loan,
    original_subsidy_cost,
    total_subsidy_cost,
    total_loan_value,
    action_date,
    awarding_agency_name,
    awarding_office_name,
    funding_agency_name,
    funding_sub_agency_name,
    funding_office_name,
    recipient_name,
    recipient_parent_name,
    recipient_country_code,
    recipient_country_name,
    recipient_address_line_1,
    recipient_address_line_2,
    recipient_city_code,
    recipient_city_name,
    recipient_county_code,
    recipient_county_name,
    recipient_state_code,
    recipient_state_name,
    recipient_zip_code,
    recipient_zip_last_4_code,
    assistance_type_description,
    award_description,
    action_type_description,
    last_modified_date
FROM assist_prime_NNN;
