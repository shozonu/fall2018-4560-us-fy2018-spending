--trimmed data table
CREATE TABLE IF NOT EXISTS assist_prime_trimmed (
    award_id_fain STRING,
    non_federal_funding_amount DECIMAL,
    total_funding_amount DECIMAL,
    face_value_of_loan DECIMAL,
    original_subsidy_cost DECIMAL,
    total_subsidy_cost DECIMAL,
    total_loan_value DECIMAL,
    action_date TIMESTAMP,
    awarding_agency_name STRING,
    awarding_office_name STRING,
    funding_agency_name STRING,
    funding_sub_agency_name STRING,
    funding_office_name STRING,
    recipient_name STRING,
    recipient_parent_name STRING,
    recipient_country_code STRING,
    recipient_country_name STRING,
    recipient_address_line_1 STRING,
    recipient_address_line_2 STRING,
    recipient_city_code STRING,
    recipient_city_name STRING,
    recipient_county_code STRING,
    recipient_county_name STRING,
    recipient_state_code STRING,
    recipient_state_name STRING,
    recipient_zip_code STRING,
    recipient_zip_last_4_code STRING,
    assistance_type_description STRING,
    award_description STRING,
    action_type_description STRING,
    last_modified_date TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
);
