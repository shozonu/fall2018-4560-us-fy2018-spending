# Group project for CIS4560 Big Data

We downloaded 2017-2018 US Spending Data from:
https://www.usaspending.gov
File size was around 1.7GB compressed; uncompresses into around 12GB.

And then we processed and loaded the data onto a remote Hadoop cluster hosted by Oracle.
From there, we were able to perform query and transform the data and output the results.
We used Beeline for executing the queries.

First, each part of the data files are loaded as external tables (not enough cluster resources to load into single table).
Then we create an internal table and load selected columns from all the records contained in the part tables.
We performed most of our queries on this trimmed table, for performance reasons.

Notes:
For 'contracts_prime_part' and 'assist_prime_part', replace 'NNN' in queries with part number.
This is because loading the entire data for the contracts or assistance tables causes Beeline to run out of memory.
Resulting '.tsv' and Excel files are uploaded to the Results folder, except for the trimmed tables containing all records because of the size. This means the Excel workbook containing the 3D Maps for the spacial and temporal is not available.
