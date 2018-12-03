--total contract spending
SELECT
    sum(current_total_value_of_award) Total_Contract_Value,
    avg(current_total_value_of_award) Average_Value
FROM contracts_prime_trimmed;

--top 100 largest contracts awarded
INSERT OVERWRITE DIRECTORY '/user/svallej5/_project/results/top_c_recipients/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
SELECT recipient_name, sum(current_total_value_of_award) Total_Contract_Value, awarding_agency_name
FROM contracts_prime_trimmed
GROUP BY recipient_name, awarding_agency_name
ORDER BY Total_Contract_Value DESC LIMIT 100;

--total contract values awarded by departments
INSERT OVERWRITE DIRECTORY '/user/svallej5/_project/results/top_dept_c_spending/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
SELECT awarding_agency_name, sum(current_total_value_of_award) Dollars_Awarded
FROM contracts_prime_trimmed
GROUP BY awarding_agency_name
ORDER BY Dollars_Awarded DESC;

--top 10 contract recipients in california
SELECT recipient_name, sum(current_total_value_of_award) Total_Value
FROM contracts_prime_trimmed
WHERE recipient_state_name = 'California'
GROUP BY recipient_name
ORDER BY Dollars_Awarded DESC LIMIT 10;

--further trim into output files
INSERT OVERWRITE DIRECTORY '/user/svallej5/_project/results/contr_trimmed/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
SELECT
    action_date,
    current_total_value_of_award,
    recipient_name,
    recipient_address_line_1,
    recipient_city_name,
    recipient_state_name,
    awarding_agency_name,
    award_type,
    award_description
FROM contracts_prime_trimmed;

--trim data into table
INSERT INTO TABLE contracts_prime_trimmed
SELECT
    award_id_piid,
    transaction_number,
    parent_award_agency_id,
    parent_award_agency_name,
    parent_award_id,
    parent_award_modification_number,
    federal_action_obligation,
    total_dollars_obligated,
    base_and_exercised_options_value,
    current_total_value_of_award,
    base_and_all_options_value,
    potential_total_value_of_award,
    action_date,
    period_of_performance_start_date,
    period_of_performance_current_end_date,
    period_of_performance_potential_end_date,
    ordering_period_end_date,
    awarding_agency_code,
    awarding_agency_name,
    awarding_sub_agency_code,
    awarding_sub_agency_name,
    awarding_office_code,
    awarding_office_name,
    funding_agency_code,
    funding_agency_name,
    funding_sub_agency_code,
    funding_sub_agency_name,
    funding_office_code,
    funding_office_name,
    foreign_funding,
    foreign_funding_description,
    sam_exception,
    sam_exception_description,
    recipient_duns,
    recipient_name,
    recipient_doing_business_as_name,
    recipient_parent_name,
    recipient_parent_duns,
    recipient_country_code,
    recipient_country_name,
    recipient_address_line_1,
    recipient_address_line_2,
    recipient_city_name,
    recipient_state_code,
    recipient_state_name,
    recipient_zip_4_code,
    recipient_congressional_district,
    recipient_phone_number,
    recipient_fax_number,
    primary_place_of_performance_country_code,
    primary_place_of_performance_country_name,
    primary_place_of_performance_city_name,
    primary_place_of_performance_county_name,
    primary_place_of_performance_state_code,
    primary_place_of_performance_state_name,
    primary_place_of_performance_zip_4,
    primary_place_of_performance_congressional_district,
    award_type,
    award_description,
    us_federal_government,
    federal_agency,
    foreign_government,
    us_government_entity,
    foreign_owned_and_located,
    for_profit_organization,
    nonprofit_organization,
    number_of_employees,
    annual_revenue,
    last_modified
FROM contracts_prime_1;
