### LEFT and RIGHT
/*
1. In the accounts table, there is a column holding the website for each
company. The last three digits specify what type of web address they are using.
A list of extensions (and pricing) is provided here. Pull these extensions and
provide how many of each website type exist in the accounts table.
*/

/*
2. There is much debate about how much the name (or even the first letter of a
company name) matters. Use the accounts table to pull the first letter of each
company name to see the distribution of company names that begin with each
letter (or number).
*/

/*
3. Use the accounts table and a CASE statement to create two groups: one group
of company names that start with a number and a second group of those company
names that start with a letter. What proportion of company names start with a
letter?
*/

/*
4. Consider vowels as a, e, i, o, and u. What proportion of company names start
with a vowel, and what percent start with anything else?
*/

### POSITION, STRPOS, and SUBSTR
/*
1. Use the accounts table to create first and last name columns that hold the
first and last names for the primary_poc.
*/

/*
2. Use the accounts table to create first and last name columns that hold the
first and last names for the primary_poc.
*/

### CONCAT
/*
1. Each company in the accounts table wants to create an email address for each
primary_poc. The email address should be the first name of the primary_poc .
last name primary_poc @ company name .com.
*/

/*
2. You may have noticed that in the previous solution some of the company names
include spaces, which will certainly not work in an email address. See if you
can create an email address that will work by removing all of the spaces in the
 account name, but otherwise your solution should be just as in question 1.
 Some helpful documentation is here.
*/

/*
3. We would also like to create an initial password, which they will change
after their first log in. The first password will be the first letter of the
primary_poc's first name (lowercase), then the last letter of their first name
(lowercase), the first letter of their last name (lowercase), the last letter of
their last name (lowercase), the number of letters in their first name, the
number of letters in their last name, and then the name of the company they are
working with, all capitalized with no spaces.
*/

### CAST
/*
1. Write a query to look at the top 10 rows to understand the columns and the
raw data in the dataset called sfcrime_data.
*/

/*
2. Write a query to change the date into the correct SQL date format. You will
need to use at least SUBSTR and CONCAT to perform this operation.
*/

/*
3. Once you have created a column in the correct format, use either CAST or ::
to convert this to a date.
*/

### COALESCE
/*
1. Run the query entered below in the SQL workspace to notice the row with
missing data.
*/

/*
2. Use COALESCE to fill in the accounts.id column with the account.id for they
NULL VALUE for the table in 1.
*/

/*
3. Use COALESCE to fill in the orders.account_id column with the account.id for
the null value for the table in 1.
*/

/*
4. Use COALESCE to fill in each of the qty and usd columns with 0 for the table
in 1.
*/

/*
5. Run the query in 1 with the WHERE removed and COUNT the number of ids.
*/

/*
6. Run the query in 5, but with the COALESCE function used in questions 2-4.
*/
