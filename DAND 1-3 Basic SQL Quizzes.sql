### ORDER BY
/*
Write a query to rethurn the 10 earliest orders in the orders table.
Include the id, date, and total_amt_usd
*/
SELECT id, occurred_at, total_amt_usd
	FROM orders
  ORDER BY occurred_at
  LIMIT 10;

/*
Write a query to return the top 5 orders in terms of largest total_amt_usd.
Include the id, account_id, and total_amt_usd.
*/
SELECT id, account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd DESC
  LIMIT 5;

/*
Write a query to return the bottom 20 orders in terms of least total.
Include the id, account_id, and total.
*/
SELECT id, account_id, total
  FROM orders
  ORDER BY total
  LIMIT 20;

### ORDER BY more than one column
/*
Write a query that returns the top 5 rows from orders ordered according to
newest to oldest, but with the largest total_amt_usd for each date listed
first for each date.
*/
SELECT *
  FROM orders
  ORDER BY occurred_at DESC, total_amt_usd DESC
  LIMIT 5;

/*
Write a query that returns the top 10 rows from orders ordered according to
oldest to newest, but with the smallest total_amt_usd for each date listed
first for each date.
*/
SELECT *
  FROM orders
  ORDER BY occured_at, total_amt_usd
  LIMIT 10;

### WHERE
/*
Pull the first 5 rows and all columns from the orders table that have a
dollar amount of glass_amt_usd great than or equal to 1000.
*/
SELECT *
  FROM orders
  WHERE gloss_amt_usd >= 1000
  LIMIT 5;

/*
Pull the first 10 rows and all columns from the orders table that have a
total_amt_usd less than 500
*/
SELECT *
  FROM orders
  WHERE total_amt_usd < 500
  LIMIT 10;

### Arithmetic Operators
/*
1. Create a column that divides the standard_amt_usd by the standard_qty to find
the unit price for standard paper for each order. Limit the results to the
first 10 orders, and include the id and account_id fields
*/
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
  FROM orders
  LIMIT 10;

/*
2. Write a query that finds the percentage of revenue that comes from poster
paper for each order. You will need to use only the columns that end with _usd.
(Try to do this without using the total column). Include the id and account_id
fields. This query yields a division by zero error to be worked around using
CASE later.
*/
SELECT id, account_id,
       poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS
			 post_perc
  FROM orders;

### LIKE
/*
Use the accounts table to find all companies whose names start with 'C'.
*/
SELECT id, name
  FROM accounts
  WHERE name LIKE 'C%';

/*
Use the accounts table to find all companies whose names contain the string
'one' somewhere in the name.
*/
SELECT id, name
  FROM accounts
  WHERE name LIKE '%one%';

/*
Use the accounts table to find all companies whose names end with 's'.
*/
SELECT id, name
  FROM accounts
  WHERE name LIKE '%s';

### IN
/*
1. Use the accounts table to find the account name, primary_poc, and
sales_rep_id for Walmart, Target, and Nordstrom.
*/
SELECT name, primary_poc, sales_rep_id
  FROM accounts
  WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/*
2. Use the web_events table to find all information regarding individuals who
were contacted via the channel of organic or adwords.
*/
SELECT *
  FROM web_events
  WHERE channel IN ('organic', 'adwords');

### NOT
/*
1. Use the accounts table to find the account name, primary_poc, and
sales_rep_id for all stores except Walmart, Target, and Nordstrom.
*/
SELECT *
  FROM web_events
  WHERE channel NOT IN ('organic', 'adwords');

/*
2. Use the web_events table to find all information regarding individuals who
were contacted via any method except organic or adwords.
*/
SELECT name, primary_poc, sales_rep_id
  FROM accounts
  WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/*
3. Find dll the companies whose names do not start with 'C'.
*/
SELECT id, name
  FROM accounts
  WHERE name NOT LIKE 'C%';

/*
4. All companies whose names do not contain the string 'one' somewhere in the
name.
*/
SELECT id, name
  FROM accounts
  WHERE name NOT LIKE '%one%';

/*
5. All companies whose names do not end with 's'.
*/
SELECT id, name
  FROM accounts
  WHERE name NOT LIKE '%s';

### AND and BETWEEN
/*
1. Write a query that returns all the orders where the standard_qty is over
1000, the poster_qty is 0, and the gloss_qty is 0.
*/
SELECT standard_qty, poster_qty, gloss_qty
  FROM orders
  WHERE standard_qty > 1000 AND poster_qty = 0 AND 			gloss_qty = 0;

/*
2. Using the accounts table find all the companies whose names do not start
with 'C' and end with 's'.
*/
SELECT name
  FROM accounts
  WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/*
3. Use the web_events table to find all information regarding individuals who
were contacted via organic or adwords and started their account at any point in
2016 sorted from newest to oldest.
*/
SELECT *
  FROM web_events
  WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01'
	      AND '2017-01-01'
  ORDER BY occurred_at DESC;

### OR
/*
1. Find list of orders ids where either gloss_qty or poster_qty is greater than
4000. Only include the id field in the resulting table.
*/
SELECT id
  FROM orders
  WHERE gloss_qty > 4000 OR poster_qty > 4000;

/*
2. Write a query that returns a list of orders where the standard_qty is zero
and either the gloss_qty or poster_qty is over 1000.
*/
SELECT id
  FROM orders
  WHERE standard_qty = 0 AND gloss_qty > 1000 OR poster_qty > 1000;

/*
3. Find all the company names that start with a 'C' or 'W', and the primary
contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
*/
SELECT name, primary_poc
  FROM accounts
  WHERE (name LIKE 'C%' OR name LIKE 'W%')
			AND (primary_poc NOT LIKE '%eana#'
			AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%'));
