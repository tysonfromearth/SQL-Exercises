### Write Your First Subquery
/*
1. Find the number of events that occur for each day for each channel.
*/
SELECT DATE_TRUNC('day', occurred_at), channel, COUNT(*) events
  FROM web_events
  GROUP BY 1, 2
  ORDER BY 1 DESC;

/*
2. Create a subquery that simply provides all of the data from your first query.
*/
SELECT *
  FROM (SELECT DATE_TRUNC('day', occurred_at), channel, COUNT(*) events
        FROM web_events
        GROUP BY 1, 2
        ORDER BY 1 DESC) sub;

/*
3. Find the average number of events for each channel. Since you broke out by
day earlier, this is giving you an average per day.
*/
SELECT channel, AVG(events) avg_events
  FROM (SELECT DATE_TRUNC('day', occurred_at), channel, COUNT(*) events
        FROM web_events
        GROUP BY 1, 2) sub
  GROUP BY 1
  ORDER BY 2 DESC;

### More On Subqueries

/*
1. Use DATE_TRUNC to pull month level information about the first order ever
placed in the orders table.
*/
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders;

/*
2. Use the result of the previous query to find only the orders that took place
in the same month and year as the first order, and then pull the average for
each type of paper quantity in this month.
*/
SELECT AVG(standard_qty) avg_std_qty, AVG(gloss_qty) avg_gls_qty,
       AVG(poster_qty) avg_post_qty
  FROM orders
  WHERE DATE_TRUNC('month', occurred_at) =
       (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

### Subquery Mania
/*
1. Provide the name of the sales_rep in each region with the largest amount of
total_amt_usd sales.
*/
SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

/*
2. For the region with the largest (sum) of sales total_amt_usd, how many total
(count) orders were placed?
*/
SELECT r.name region_name, COUNT(o.total) total_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
GROUP BY region_name
HAVING SUM(o.total_amt_usd) = (
  SELECT MAX(sales_total)
  FROM
    (SELECT r.name region, SUM(o.total_amt_usd) sales_total
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps sr
    ON a.sales_rep_id = sr.id
    JOIN region r
    ON sr.region_id = r.id
    GROUP BY region) iq);

/*
3. For the name of the account that purchased the most (in total over their
lifetime as a customer) standard_qty paper, how many accounts still had more in
total purchases? Note we could use LIMIT 1 in sub and SELECT total_stand from
that query instead of SELECTing MAX(total_stand) from that same query.
*/
SELECT a.name account, SUM(o.total) AS total_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY account
HAVING SUM(o.total) > (
  SELECT MAX(total_stand)
  FROM (
    SELECT a.name account, SUM(o.standard_qty) total_stand
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    GROUP BY account) sub)
ORDER BY 2 DESC

/*
4. For the customer that spent the most (in total over their lifetime as a
customer) total_amt_usd, how many web_events did they have for each channel?
*/
SELECT a.name customer, w.channel, COUNT(*) top_cust_events
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.name = (
  SELECT sub.customer
  FROM (
    SELECT a.name customer, SUM(o.total_amt_usd) sales_total
    FROM accounts a
    JOIN orders o
    ON o.account_id = a.id
    GROUP BY customer
    ORDER BY sales_total DESC
    LIMIT 1) sub)
GROUP BY 1, 2
ORDER BY 1;

/*
5. What is the lifetime average amount spent in terms of total_amt_usd for the
top 10 total spending accounts?
*/
SELECT AVG(sub.tot_spent)
FROM (
  SELECT a.name customer, SUM(o.total_amt_usd) tot_spent
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY customer
  ORDER BY tot_spent DESC
  LIMIT 10) sub;

/*
6. What is the lifetime average amount spent in terms of total_amt_usd for only
the companies that spent more than the average of all orders.
*/
SELECT AVG(tot_spent)
FROM (
  SELECT a.id, a.name, avg(o.total_amt_usd) tot_spent
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1, 2
  HAVING AVG(o.total_amt_usd) >
    (SELECT AVG(total_amt_usd) avg_spent FROM orders)
  ORDER BY 3 DESC) sub;

### WITH

/*
1. Provide the name of the sales_rep in each region with the largest amount of
total_amt_usd sales.
*/
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
  FROM sales_reps s
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN orders o
  ON o.account_id = a.id
  JOIN region r
  ON r.id = s.region_id
  GROUP BY 1, 2
  ORDER BY 3 DESC),

t2 AS (
  SELECT region_name, MAX(total_amt) total_amt
  FROM t1
  GROUP BY 1)

SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t2
JOIN t1
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

/*
2. For the region with the largest (sum) of sales total_amt_usd, how many total
(count) orders were placed?
*/
WITH iq as (
 SELECT r.name region, SUM(o.total_amt_usd) sales_total
 FROM orders o
 JOIN accounts a
 ON o.account_id = a.id
 JOIN sales_reps sr
 ON a.sales_rep_id = sr.id
 JOIN region r
 ON sr.region_id = r.id
 GROUP BY region
 ORDER BY sales_total DESC
 LIMIT 1)

SELECT r.name top_region, COUNT(o.total) total_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps sr
ON a.sales_rep_id = sr.id
JOIN region r
ON sr.region_id = r.id
JOIN iq
ON iq.region = r.name
GROUP BY top_region, iq
HAVING SUM(o.total_amt_usd) = (SELECT sales_total FROM iq);

/*
3. For the name of the account that purchased the most (in total over their
lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?
*/
WITH sub AS (
  SELECT a.name account, SUM(o.standard_qty) total_stand
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  GROUP BY account),

counter AS (
  SELECT a.name account, SUM(o.total) AS total_orders
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  GROUP BY account
  HAVING SUM(o.total) > (
    SELECT MAX(total_stand)
    FROM sub)
    ORDER BY 2 DESC)

SELECT COUNT(*)
FROM counter;

/*
4. For the customer that spent the most (in total over their lifetime as a
customer) total_amt_usd, how many web_events did they have for each channel?
*/
WITH sub AS (
  SELECT a.name customer, SUM(o.total_amt_usd) sales_total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY customer
  ORDER BY sales_total DESC
  LIMIT 1)

SELECT a.name customer, w.channel, COUNT(*) top_cust_events
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.name = (
  SELECT sub.customer
  FROM sub)
GROUP BY 1, 2
ORDER BY 3 DESC;

/*
5. What is the lifetime average amount spent in terms of total_amt_usd for the
top 10 total spending accounts?
*/
WITH sub AS (
  SELECT a.name customer, SUM(o.total_amt_usd) tot_spent
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY customer
  ORDER BY tot_spent DESC
  LIMIT 10)

SELECT AVG(sub.tot_spent)
FROM sub;

/*
6. What is the lifetime average amount spent in terms of total_amt_usd for only
the companies that spent more than the average of all orders.
*/
WITH sub AS (
  SELECT a.id, a.name, avg(o.total_amt_usd) tot_spent
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1, 2
  HAVING AVG(o.total_amt_usd) >
    (SELECT AVG(total_amt_usd) avg_spent FROM orders)
  ORDER BY 3 DESC)

SELECT AVG(tot_spent)
FROM sub;
