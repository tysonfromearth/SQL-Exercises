### Window Functions 1
/*
1. Create a running total of standard_amt_usd (in the orders table) over order
time with no date truncation. Your final table should have two columns: one with
the amount being added for each new row, and a second with a running total.
*/

### Window Functions 2
/*
1. Now, modify your query from the previous quiz to include partitions. Still
create a running total of standard_amt_usd (in the orders table) over order
time, but this time, date truncate occurred_at by year and partition by that
same year-truncated occurred_at variable. Your final table should have three
columns: One with the amount being added for each row, one for the truncated
date, and a final column with the running total within each year.
*/

### ROW_NUMBER and RANK
/*
1. Select the id, account_id, and total variable from the orders table, then
create a column called total_rank that ranks this total amount of paper ordered
(from highest to lowest) for each account using a partition. Your final table
should have these four columns.
*/

### Aliases for Multiple Windows Functions
/*
1. Create and use an alias to shorten the following query (which is different
than the one in Derek's previous video) that has multiple window functions.
Name the alias account_year_window.
*/

### Comparing a Row to a Previous Row
/*
1. Imagine you're an analyst at Parch & Posey and you want to determine how the
current order's total revenue ("total" meaning from sales of all types of paper)
compares to the next order's total revenue. Modify the query below to perform
this analysis.  You'll need to use occurred_at and total_amt_usd in the orders
table along with LEAD to do so. In your query results, there should be four
columns: occurred_at, total_amt_usd, lead, and lead_difference.
*/
SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
       standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
FROM (
SELECT account_id,
       SUM(standard_qty) AS standard_sum
  FROM orders
 GROUP BY 1
 ) sub

/* My modified version */


### Percentiles
/*
1. Use the NTILE functionality to divide the accounts into 4 levels in terms of
the amount of standard_qty for their orders. Your resulting table should have
the account_id, the occurred_at time for each order, the total amount of
standard_qty paper purchased, and one of four levels in a standard_quartile
column.
*/

/*
2. Use the NTILE functionality to divide the accounts into two levels in terms
of the amount of gloss_qty for their orders. Your resulting table should have
the account_id, the occurred_at time for each order, the total amount of
gloss_qty paper purchased, and one of two levels in a gloss_half column.
*/

/*
3. Use the NTILE functionality to divide the orders for each account into 100
levels in terms of the amount of total_amt_usd for their orders. Your resulting
table should have the account_id, the occurred_at time for each order, the total
amount of total_amt_usd paper purchased, and one of 100 levels in a
total_percentile column.
*/
