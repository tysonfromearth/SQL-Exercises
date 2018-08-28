### SUM
/*
1. Find the total amount of poster_qty paper ordered in the orders table.
*/
SELECT SUM(poster_qty) poster_sales
  FROM orders;

/*
2. Find the total amount of standard_qty paper ordered in the orders table.
*/
SELECT SUM(standard_qty) standard_sales
  FROM orders;

/*
3. Find the total dollar amount of sales using the total_amt_usd in the orders
table.
*/
SELECT SUM(total_amt_usd) total_sales
  FROM orders;

/*
4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for
each order in the orders table. This should give a dollar amount for each order
in the table.
*/
SELECT standard_amt_usd + gloss_amt_usd standard_gloss_usd
  FROM orders;

/*
5. Find the standard_amt_usd per unit of standard_qty paper. Your solution
should use both an aggregation and a mathematical operator.
*/
SELECT SUM(standard_amt_usd) / SUM(standard_qty) standard_unit_price
  FROM orders;

### MIN, MAX, and AVG
/*
1. When was the earliest order ever placed? You only need to return the date.
*/
SELECT MIN(occurred_at) first_order
  FROM orders;

/*
2. Try performing the same query as in question 1 without using an aggregation
function.
*/
SELECT occurred_at
  FROM orders
  ORDER BY occurred_at
  LIMIT 1;

/*
3. When did the most recent (latest) web_event occur?
*/
SELECT MAX(occurred_at) most_recent_web_event
  FROM web_events;

/*
4. Try to perform the result of the previous query without using an aggregation
function.
*/
SELECT occurred_at
  FROM web_events
  ORDER BY occurred_at DESC
  LIMIT 1;

/*
5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as
the mean amount of each paper type purchased per order. Your final answer should
have 6 values - one for each paper type for the average number of sales, as well
as the average amount.
*/
SELECT AVG(gloss_amt_usd) mean_gloss_usd,
		   AVG(poster_amt_usd) mean_poster_usd,
       AVG(standard_amt_usd) standard_usd,
       AVG(gloss_qty) mean_gloss_qty,
       AVG(poster_qty) mean_poster_qty,
       AVG(standard_qty) mean_standard_qty
  FROM orders;

/*
6. Via the video, you might be interested in how to calculate the MEDIAN. Though
this is more advanced than what we have covered so far try finding - what is the
MEDIAN total_usd spent on all orders?
*/

### GROUP BY Part I
/*
1. Which account (by name) placed the earliest order? Your solution should have
the account name and the date of the order.
*/
SELECT a.name, o.occurred_at
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  ORDER BY occurred_at
  LIMIT 1;

/*
2. Find the total sales in usd for each account. You should include two columns
- the total sales for each company's orders in usd and the company name.
*/
SELECT a.name, SUM(o.total_amt_usd)
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

/*
3. Via what channel did the most recent (latest) web_event occur, which account
was associated with this web_event? Your query should return only three values -
the date, channel, and account name.
*/
SELECT we.occurred_at, we.channel, a.name
  FROM web_events we
  JOIN accounts a
  ON a.id = we.account_id
  ORDER BY we.occurred_at DESC
  LIMIT 1;

/*
4. Find the total number of times each type of channel from the web_events was
used. Your final table should have two columns - the channel and the number of
times the channel was used.
*/
SELECT we.channel, COUNT(*)
  FROM web_events we
  GROUP BY we.channel;

/*
5. Who was the primary contact associated with the earliest web_event?
*/
SELECT we.occurred_at, a.primary_poc
  FROM web_events we
  JOIN accounts a
  ON a.id = we.account_id
  ORDER BY we.occurred_at
  LIMIT 1;

/*
6. What was the smallest order placed by each account in terms of total usd.
Provide only two columns - the account name and the total usd. Order from
smallest dollar amounts to largest.
*/
SELECT a.name, MIN(o.total_amt_usd) smallest_order
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name
  ORDER BY smallest_order;

/*
7. Find the number of sales reps in each region. Your final table should have
two columns - the region and the number of sales_reps. Order from fewest reps to
most reps.
*/
SELECT r.name, COUNT(sr.id) number_of_reps
  FROM regions r
  JOIN sales_reps sr
  ON r.id = sr.region_id
  GROUP BY r.name
  ORDER BY number_of_reps;

### GROUP BY Part II
/*
1. For each account, determine the average amount of each type of paper they
purchased across their orders. Your result should have four columns - one for
the account name and one for the average quantity purchased for each of the
paper types for each account.
*/
SELECT a.name, AVG(o.poster_qty) avg_poster_qty,
AVG(o.gloss_qty) avg_gloss_qty, AVG(o.standard_qty) avg_standard_qty
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

/*
2. For each account, determine the average amount spent per order on each paper
type. Your result should have four columns - one for the account name and one
for the average amount spent on each paper type.
*/
SELECT a.name, AVG(o.poster_amt_usd) avg_poster_usd,
AVG(o.gloss_amt_usd) avg_gloss_usd, AVG(o.standard_amt_usd) avg_standard_usd
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

/*
3. Determine the number of times a particular channel was used in the web_events
table for each sales rep. Your final table should have three columns - the name
of the sales rep, the channel, and the number of occurrences. Order your table
with the highest number of occurrences first.
*/
SELECT sr.name, we.channel, COUNT(we.channel) count
  FROM sales_reps sr
  JOIN accounts a
  ON sr.id = a.sales_rep_id
  JOIN web_events we
  ON a.id = we.account_id
  GROUP BY sr.name, we.channel
  ORDER BY count DESC;

/*
4. Determine the number of times a particular channel was used in the web_events
able for each region. Your final table should have three columns - the region
name, the channel, and the number of occurrences. Order your table with the
highest number of occurrences first.
*/
SELECT r.name, we.channel, COUNT(we.channel) count
  FROM region r
  JOIN sales_reps sr
  ON r.id = sr.region_id
  JOIN accounts a
  ON sr.id = a.sales_rep_id
  JOIN web_events we
  ON a.id = we.account_id
  GROUP BY r.name, we.channel
  ORDER BY count DESC;

### DISTINCT
/*
1. Use DISTINCT to test if there are any accounts associated with more than one
region.
*/
SELECT a.name account, r.name region
  FROM accounts a
  JOIN sales_reps
  ON a.sales_rep_id = sales_reps.id
  JOIN region r
  ON r.id = sales_reps.region_id;

/* and */

SELECT DISTINCT id, name
  FROM accounts;

/*
2. Have any sales reps worked on more than one account?
*/
SELECT sr.name rep, COUNT(a.name) accounts
  FROM accounts a
  JOIN sales_reps sr
  ON a.sales_rep_id = sr.id
  GROUP BY rep
  ORDER BY accounts;

/* and */

SELECT DISTINCT id, name
  FROM sales_reps;

### HAVING
/*
1. How many of the sales reps have more than 5 accounts that they manage?
*/
SELECT sr.name rep, COUNT(a.name) accounts
  FROM accounts a
  JOIN sales_reps sr
  ON a.sales_rep_id = sr.id
  GROUP BY rep
  HAVING COUNT(*) > 5
  ORDER BY accounts;

/*
2. How many accounts have more than 20 orders?
*/
SELECT a.name account, COUNT(*) orders
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account
  HAVING COUNT(*) > 20
  ORDER BY orders;

/*
3. Which account has the most orders?
*/
SELECT a.name account, COUNT(*) orders
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account
  ORDER BY orders DESC
  LIMIT 1;

/*
4. How many accounts spent more than 30,000 usd total across all orders?
*/
SELECT a.name account, SUM(total_amt_usd) spending
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account
  HAVING SUM(total_amt_usd) > 30000
  ORDER BY spending DESC;

/*
5. How many accounts spent less than 1,000 usd total across all orders?
*/
SELECT a.name account, SUM(total_amt_usd) spending
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account
  HAVING SUM(total_amt_usd) < 1000
  ORDER BY spending DESC;

/*
6. Which account has spent the most with us?
*/
SELECT a.name account, SUM(total_amt_usd) spending
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account
  ORDER BY spending DESC
  LIMIT 1;

/*
7. Which account has spent the least with us?
*/
SELECT a.name account, SUM(total_amt_usd) spending
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account
  ORDER BY spending
  LIMIT 1;

/*
8. Which accounts used facebook as a channel to contact customers more than 6
times?
*/
SELECT a.name account, we.channel channel, COUNT(*) count
  FROM accounts a
  JOIN web_events we
  ON a.id = we.account_id
  WHERE channel = 'facebook'
  GROUP BY account, channel
  HAVING COUNT(*) > 6
  ORDER BY count;

/*
9. Which account used facebook most as a channel?
*/
SELECT a.name account, we.channel channel, COUNT(*) count
  FROM accounts a
  JOIN web_events we
  ON a.id = we.account_id
  WHERE channel = 'facebook'
  GROUP BY account, channel
  ORDER BY count DESC
  LIMIT 1;

/*
10. Which channel was most frequently used by most accounts?
*/
SELECT a.name account, we.channel channel, COUNT(*) count
  FROM accounts a
  JOIN web_events we
  ON a.id = we.account_id
  GROUP BY account, channel
  ORDER BY count DESC
  LIMIT 10;

### DATE Functions
/*
1. Find the sales in terms of total dollars for all orders in each year,
ordered from greatest to least. Do you notice any trends in the yearly sales
totals?
*/
SELECT DATE_PART('year', occurred_at), SUM(total_amt_usd) spending
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC;

/*
2. Which month did Parch & Posey have the greatest sales in terms of total
dollars? Are all months evenly represented by the dataset?
*/
SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) spending
  FROM orders
  /* 2013 and 2017 only have info for one month each, so discard */
  WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
  GROUP  BY 1
  ORDER BY 2;

/*
3. Which year did Parch & Posey have the greatest sales in terms of total number
of orders? Are all years evenly represented by the dataset?
*/
SELECT DATE_PART('year', occurred_at) order_year, COUNT(*) num_sales
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC;

/*
4. Which month did Parch & Posey have the greatest sales in terms of total
number of orders? Are all months evenly represented by the dataset?
*/
SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) num_orders
  FROM orders
  /* 2013 and 2017 only have info for one month each, so discard */
  WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
  GROUP  BY 1
  ORDER BY 2 DESC;

/*
5. In which month of which year did Walmart spend the most on gloss paper in
terms of dollars?
*/
SELECT DATE_TRUNC('month', o.occurred_at), a.name,
SUM(o.gloss_amt_usd) total_gloss_usd
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  WHERE a.name = 'Walmart'
  GROUP BY 1, 2
  ORDER BY 3 DESC
  LIMIT 1;

### CASE
/*
1. We would like to understand 3 different levels of customers based on the
amount associated with their purchases. The top branch includes anyone with a
Lifetime Value (total sales of all orders) greater than 200,000 usd. The second
branch is between 200,000 and 100,000 usd. The lowest branch is anyone under
100,000 usd. Provide a table that includes the level associated with each
account. You should provide the account name, the total sales of all orders for
the customer, and the level. Order with the top spending customers listed first.
*/
SELECT account_id, SUM(total_amt_usd) spending,
       CASE WHEN SUM(total_amt_usd) > 200000 then 'top'
            WHEN SUM(total_amt_usd) > 100000 then 'middle'
            ELSE 'low' END AS cust_level
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC;

/*
2. We would now like to perform a similar calculation to the first, but we want
to obtain the total amount spent by customers only in 2016 and 2017. Keep the
same levels as in the previous question. Order with the top spending customers
listed first.
*/
SELECT account_id, SUM(total_amt_usd) spending,
       CASE WHEN SUM(total_amt_usd) > 200000 then 'top'
            WHEN SUM(total_amt_usd) > 100000 then 'middle'
            ELSE 'low' END AS cust_level
  FROM orders
  WHERE occurred_at >= '2016-01-01'
  GROUP BY 1
  ORDER BY 2 DESC;

/*
3. We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders. Create a table with the sales rep name,
the total number of orders, and a column with top or not depending on if they
have more than 200 orders. Place the top sales people first in your final table.
*/
SELECT sr.name, COUNT(*) orders, SUM(total_amt_usd)
       CASE WHEN COUNT(*) > 200 THEN 'top' else 'not' END AS rep_level
  FROM sales_reps sr
  JOIN accounts a
  ON a.sales_rep_id = sr.id
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC;

/*
4. The previous didn't account for the middle, nor the dollar amount associated
with the sales. Management decides they want to see these characteristics
represented as well. We would like to identify top performing sales reps, which
are sales reps associated with more than 200 orders or more than 750000 in total
sales. The middle group has any rep with more than 150 orders or 500000 in
sales. Create a table with the sales rep name, the total number of orders, total
sales across all orders, and a column with top, middle, or low depending on this
criteria. Place the top sales people based on dollar amount of sales first in
your final table. You might see a few upset sales people by this criteria!
*/
SELECT sr.name, COUNT(*) orders, SUM(o.total_amt_usd),
       CASE WHEN COUNT(*) > 200 or SUM(o.total_amt_usd) > 750000 THEN 'top'
            WHEN COUNT(*) > 150 or SUM(o.total_amt_usd) > 500000 THEN 'middle'
            ELSE 'low' END AS rep_level
  FROM sales_reps sr
  JOIN accounts a
  ON a.sales_rep_id = sr.id
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 3 DESC;
