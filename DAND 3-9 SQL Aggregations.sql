### SUM
/*
1. Find the total amount of poster_qty paper ordered in the orders table.
*/

/*
2. Find the total amount of standard_qty paper ordered in the orders table.
*/

/*
3. Find the total dollar amount of sales using the total_amt_usd in the orders
table.
*/

/*
4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for
each order in the orders table. This should give a dollar amount for each order in the table.
*/

/*
5. Find the standard_amt_usd per unit of standard_qty paper. Your solution
should use both an aggregation and a mathematical operator.
*/

### MIN, MAX, and AVG
/*
1. When was the earliest order ever placed? You only need to return the date.
*/

/*
2. Try performing the same query as in question 1 without using an aggregation
function.
*/

/*
3. When did the most recent (latest) web_event occur?

*/

/*
4. Try to perform the result of the previous query without using an aggregation
function.
*/

/*
5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as
the mean amount of each paper type purchased per order. Your final answer should
have 6 values - one for each paper type for the average number of sales, as well
as the average amount.
*/

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

/*
2. Find the total sales in usd for each account. You should include two columns
- the total sales for each company's orders in usd and the company name.
*/

/*
3. Via what channel did the most recent (latest) web_event occur, which account
was associated with this web_event? Your query should return only three values -
the date, channel, and account name.
*/

/*
4. Find the total number of times each type of channel from the web_events was
used. Your final table should have two columns - the channel and the number of
times the channel was used.
*/

/*
5. Who was the primary contact associated with the earliest web_event?
*/

/*
6. What was the smallest order placed by each account in terms of total usd.
Provide only two columns - the account name and the total usd. Order from
smallest dollar amounts to largest.
*/

/*
7. Find the number of sales reps in each region. Your final table should have
two columns - the region and the number of sales_reps. Order from fewest reps to
most reps.
*/

### GROUP BY Part II
/*
1. For each account, determine the average amount of each type of paper they
purchased across their orders. Your result should have four columns - one for
the account name and one for the average quantity purchased for each of the
paper types for each account.
*/

/*
2. For each account, determine the average amount spent per order on each paper
type. Your result should have four columns - one for the account name and one
for the average amount spent on each paper type.
*/

/*
3. Determine the number of times a particular channel was used in the web_events
table for each sales rep. Your final table should have three columns - the name
of the sales rep, the channel, and the number of occurrences. Order your table
with the highest number of occurrences first.
*/

/*
4. Determine the number of times a particular channel was used in the web_events
able for each region. Your final table should have three columns - the region
name, the channel, and the number of occurrences. Order your table with the
highest number of occurrences first.
*/

### DISTINCT
/*
1. Use DISTINCT to test if there are any accounts associated with more than one
region.
*/

/*
2. Have any sales reps worked on more than one account?
*/

### HAVING
/*
1. How many of the sales reps have more than 5 accounts that they manage?
*/

/*
2. How many accounts have more than 20 orders?
*/

/*
3. Which account has the most orders?
*/

/*
4. How many accounts spent more than 30,000 usd total across all orders?
*/

/*
5. How many accounts spent less than 1,000 usd total across all orders?
*/

/*
6. Which account has spent the most with us?
*/

/*
7. Which account has spent the least with us?
*/

/*
8. Which accounts used facebook as a channel to contact customers more than 6
times?
*/

/*
9. Which account used facebook most as a channel?
*/

/*
10. Which channel was most frequently used by most accounts?
*/

### DATE Functions
/*
1. Find the sales in terms of total dollars for all orders in each year,
ordered from greatest to least. Do you notice any trends in the yearly sales
totals?
*/

/*
2. Which month did Parch & Posey have the greatest sales in terms of total
dollars? Are all months evenly represented by the dataset?
*/

/*
3. Which year did Parch & Posey have the greatest sales in terms of total number
of orders? Are all years evenly represented by the dataset?
*/

/*
4. Which month did Parch & Posey have the greatest sales in terms of total
number of orders? Are all months evenly represented by the dataset?
*/

/*
5. In which month of which year did Walmart spend the most on gloss paper in
terms of dollars?
*/
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

/*
2. We would now like to perform a similar calculation to the first, but we want
to obtain the total amount spent by customers only in 2016 and 2017. Keep the
same levels as in the previous question. Order with the top spending customers
listed first.
*/

/*
3. We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders. Create a table with the sales rep name,
the total number of orders, and a column with top or not depending on if they
have more than 200 orders. Place the top sales people first in your final table.
*/

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
