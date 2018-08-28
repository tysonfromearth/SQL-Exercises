### LEFT and RIGHT
/*
1. In the accounts table, there is a column holding the website for each
company. The last three digits specify what type of web address they are using.
A list of extensions (and pricing) is provided here. Pull these extensions and
provide how many of each website type exist in the accounts table.
*/
SELECT RIGHT(website, 3) AS domain, COUNT(*) count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*
2. There is much debate about how much the name (or even the first letter of a
company name) matters. Use the accounts table to pull the first letter of each
company name to see the distribution of company names that begin with each
letter (or number).
*/
SELECT LEFT(name, 1) AS first_letter, COUNT(*) count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*
3. Use the accounts table and a CASE statement to create two groups: one group
of company names that start with a number and a second group of those company
names that start with a letter. What proportion of company names start with a
letter?
*/
WITH t1 AS (
  SELECT CASE WHEN LEFT(a.name, 1) IN ('1','2','3','4','5','6','7','8','9','0')
              THEN 0
	            ELSE 1 END AS is_let
  FROM accounts a)

SELECT SUM(is_let) let_count, COUNT(*)-SUM(is_let) num_count, count(*) total
  FROM t1

/*
4. Consider vowels as a, e, i, o, and u. What proportion of company names start
with a vowel, and what percent start with anything else?
*/
WITH t1 AS (
  SELECT CASE WHEN LEFT(UPPER(a.name), 1) IN ('A','E','I','O','U') THEN 1
	            ELSE 0 END AS is_vowel
FROM accounts a)

SELECT SUM(is_vowel) vowel_count, COUNT(*)-SUM(is_vowel) cons_count,
       count(*) total
FROM t1;

### POSITION, STRPOS, and SUBSTR
/*
1. Use the accounts table to create first and last name columns that hold the
first and last names for the primary_poc.
*/
SELECT LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) AS first,
       RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS last
FROM accounts;

/*
2. Use the sales_reps table to create first and last name columns that hold the
first and last names for every rep.
*/
SELECT LEFT(name, POSITION(' ' IN name)-1) AS first,
       RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) AS last
FROM sales_reps;

### CONCAT
/*
1. Each company in the accounts table wants to create an email address for each
primary_poc. The email address should be the first name of the primary_poc .
last name primary_poc @ company name .com.
*/
SELECT LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) || '.' ||
       RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc))
         || '@' || name || '.com'
FROM accounts

/*
2. You may have noticed that in the previous solution some of the company names
include spaces, which will certainly not work in an email address. See if you
can create an email address that will work by removing all of the spaces in the
 account name, but otherwise your solution should be just as in question 1.
 Some helpful documentation is here.
*/
SELECT LEFT(LOWER(primary_poc), POSITION(' ' IN primary_poc)-1) || '.' ||
       RIGHT(LOWER(primary_poc), LENGTH(primary_poc) -
         POSITION(' ' IN primary_poc)) || '@' ||
       REPLACE(LOWER(name), ' ', '') || '.com'
FROM accounts

/*
3. We would also like to create an initial password, which they will change
after their first log in. The first password will be the first letter of the
primary_poc's first name (lowercase), then the last letter of their first name
(lowercase), the first letter of their last name (lowercase), the last letter of
their last name (lowercase), the number of letters in their first name, the
number of letters in their last name, and then the name of the company they are
working with, all capitalized with no spaces.
*/
WITH t1 AS (
  SELECT LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first,
         RIGHT(primary_poc, LENGTH(primary_poc) -
           POSITION(' ' IN primary_poc)) AS last, UPPER(name) AS account
  FROM accounts)
SELECT CONCAT(LEFT(LOWER(first), 1), RIGHT(first, 1), LEFT(LOWER(last), 1),
             RIGHT(last, 1), LENGTH(first), LENGTH(last),
             REPLACE(account, ' ', '')) temp_password
FROM t1

### CAST
/*
1. Write a query to look at the top 10 rows to understand the columns and the
raw data in the dataset called sfcrime_data.
*/
SELECT *
FROM sf_crime_data
LIMIT 10;

/*
2. Write a query to change the date into the correct SQL date format. You will
need to use at least SUBSTR and CONCAT to perform this operation.
*/
SELECT (SUBSTR(date, 7, 4) || '-' || SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2)) AS new_date,
	   (SUBSTR(date, 7, 4) || '-' || SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2))::DATE formatted_date
FROM sf_crime_data

/*
3. Once you have created a column in the correct format, use either CAST or ::
to convert this to a date.
*/
SELECT date orig_date,
	   (SUBSTR(date, 7, 4) || '-' || SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2)) AS new_date,
	   (SUBSTR(date, 7, 4) || '-' || SUBSTR(date, 1, 2) || '-' || SUBSTR(date, 4, 2))::DATE formatted_date
FROM sf_crime_data
LIMIT 10;

### COALESCE
/*
1. Run the query entered below in the SQL workspace to notice the row with
missing data.
*/
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*
2. Use COALESCE to fill in the accounts.id column with the account.id for they
NULL VALUE for the table in 1.
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long,
       a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*
3. Use COALESCE to fill in the orders.account_id column with the account.id for
the null value for the table in 1.
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long,
       a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id,
       o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total,
       o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*
4. Use COALESCE to fill in each of the qty and usd columns with 0 for the table
in 1.
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long,
       a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id,
       o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty,
       COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty,
       COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd,
       COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd,
       COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*
5. Run the query in 1 with the WHERE removed and COUNT the number of ids.
*/
SELECT COUNT(a.id)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

/*
6. Run the query in 5, but with the COALESCE function used in questions 2-4.
*/
  SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc,
       a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at,
       COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty,
       COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total,
       COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd,
       COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
  FROM accounts a
  LEFT JOIN orders o
  ON a.id = o.account_id
