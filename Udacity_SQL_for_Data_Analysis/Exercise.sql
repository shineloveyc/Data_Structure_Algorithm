/**SQL coding exercise**/

/**Pulls the first 5 rows and all columns from
the orders table that have a dollar
amount of gloss_amt_usd greater than
or equal to 1000.
**/
SELECT *
FROM orders
WHERE gloss_amt_usd>=1000
LIMIT 5;

/**Pulls the first 10 rows and all columns from
the orders table that have a total_amt_usd less
than 500.**/

SELECT *
FROM orders
WHERE total_amt_usd<500
LIMIT 10;

/**Filter the accounts table to include the company
name, website, and the primary point of contact
(primary_poc) just for the Exxon Mobil company in
the accounts table.**/

SELECT name, website,primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'

/**Create a column that divides the standard_amt_usd
by the standard_qty to find the unit price for standard
paper for each order. Limit the results to the first 10
orders, and include the id and account_id fields.**/

SELECT id, account_id, standard_amt_usd/standard_qty AS standard_unit_price
FROM orders
LIMIT 10;

/**Write a query that finds the percentage of revenue
that comes from poster paper for each order. You will need
to use only the columns that end with _usd. (Try to do
this without using the total column.) Display the id and
account_id fields also.**/

SELECT id, account_id, poster_amt_usd/total_amt_usd AS pct_amt_from_poster
FROM orders
LIMIT 10;

/**All the companies whose names start with 'C'.**/
SELECT *
FROM accounts
WHERE name LIKE 'C%';

/**All the companies whose names not start with 'C'.**/
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

/**All companies whose names contain the string 'one'
somewhere in the name.
**/
SELECT *
FROM accounts
WHERE name LIKE '%one%';

/**All companies whose names does not contain the string 'one'
somewhere in the name.
**/
SELECT *
FROM accounts
WHERE name NOT LIKE '%one%';

/**All companies whose names end with 's'.**/
SELECT *
FROM accounts
WHERE name LIKE '%s';

/**All companies whose names does not end with 's'.**/
SELECT *
FROM accounts
WHERE name NOT LIKE '%s';

/**find all the companies whose names do not start
with 'C' and end with 's'.**/
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';


/**Use the accounts table to find the account name, primary_poc,
and sales_rep_id for Walmart, Target, and Nordstrom.**/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/**Use the web_events table to find all information regarding
individuals who were contacted via the channel of organic or
adwords.**/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/**Use the accounts table to find the account name, primary
poc, and sales rep id for all stores except Walmart, Target
, and Nordstrom.**/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/**Use the web_events table to find all information regarding
individuals who were contacted via any method except using
organic or adwords methods.**/

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/**returns all the orders where the standard_qty is over 1000,
 the poster_qty is 0, and the gloss_qty is 0.**/

SELECT *
FROM orders
WHERE standard_qty>1000 AND poster_qty=0 AND gloss_qty=0;


/**displays the order date and gloss_qty data for all orders
where gloss_qty is between 24 and 29. **/

SELECT *
FROM orders
WHERE gloss_qty between 24 and 29;

/**Use the web_events table to find all information regarding
individuals who were contacted via the organic or adwords channels,
 and started their account at any point in 2016, sorted from newest
to oldest.**/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01T00:00:00.000Z' AND '2016-12-31T24:00:00.000Z'
ORDER BY occurred_at DESC;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/**Find list of orders ids where either gloss_qty or poster_qty
is greater than 4000. Only include the id field in the resulting table.**/

SELECT id
FROM orders
WHERE gloss_qty>4000 OR poster_qty>4000;

/**Write a query that returns a list of orders where the standard_qty
is zero and either the gloss_qty or poster_qty is over 1000.**/

SELECT *
FROM orders
WHERE standard_qty=0 AND (gloss_qty>1000 OR poster_qty>1000);

/**Find all the company names that start with a 'C' or 'W', and
the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.**/

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
            AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
            AND primary_poc NOT LIKE '%eana%';

/**
pulling standard_qty, gloss_qty, and poster_qty from the orders
table, and the website and the primary_poc from the accounts table.
**/
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts on orders.account_id = accounts.id;

SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

/**Provide a table for all web_events associated with account name of Walmart. **/

SELECT a.name, a.primary_poc, w.occurred_at,w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name='Walmart';

/**Provide a table that provides the region for each sales_rep along
with their associated accounts.**/
SELECT s.name rep, r.name region, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name;

/**Provide the name for each region for every order, as well as the
account name and the unit price they paid (total_amt_usd/total) for
the order. **/
/**when column name repeat, must give alias to make sure all cols displayed**/

SELECT r.name region, a.name account,
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

/**Provide a table that provides the region for each sales_rep along with their
associated accounts. **/
SELECT s.name reps, r.name region, a.name account_name
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY account_name;

/**This time only for accounts where the sales rep has a first name starting
with S and in the Midwest region.**/

SELECT r.name region,s.name reps, a.name account_name
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY account_name;

/** This time only for accounts where the sales rep has a last name starting
with K and in the Midwest region. Your**/
SELECT r.name region,s.name reps, a.name account_name
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY account_name;

/**Provide the name for each region for every order, as well as the account
name and the unit price they paid (total_amt_usd/total) for the order.
However, you should only provide the results if the standard order quantity
exceeds 100.**/

SELECT r.name region, a.name account,
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty>100;

/** However, you should only provide the results if the standard order quantity
 exceeds 100 and the poster order quantity exceeds 50.**/

 SELECT r.name region, a.name account,
        o.total_amt_usd/(o.total + 0.01) unit_price
 FROM region r
 JOIN sales_reps s
 ON s.region_id = r.id
 JOIN accounts a
 ON a.sales_rep_id = s.id
 JOIN orders o
 ON o.account_id = a.id
 WHERE o.standard_qty>100 AND o.poster_qty>50;
 ORDER BY unit_price;

/**sort the larget unit price first**/
 SELECT r.name region, a.name account,
        o.total_amt_usd/(o.total + 0.01) unit_price
 FROM region r
 JOIN sales_reps s
 ON s.region_id = r.id
 JOIN accounts a
 ON a.sales_rep_id = s.id
 JOIN orders o
 ON o.account_id = a.id
 WHERE o.standard_qty>100 AND o.poster_qty>50
 ORDER BY unit_price DESC;

SELECT DISTINCT a.id, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
AND a.id = 1001;

/**Find all the orders that occurred in 2015.Your final table should have 4
columns: occurred_at, account name, order total, and order total_amt_usd.**/

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
AND o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC;

/**can also use where clause**/
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

/**Aggregate Function**/

/**Find the total amount of poster_qty paper ordered in the orders table.**/
SELECT COUNT(*)
FROM orders
WHERE poster_qty !=0;

SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;

/**Find the total amount of standard_qty paper ordered in the orders table.**/

SELECT COUNT(*)
FROM orders
WHERE standard_qty !=0;

SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;

/**Find the total dollar amount of sales using the total_amt_usd in the orders
 table.**/

 SELECT SUM(total_amt_usd)
 FROM orders;

/**Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for
each order in the orders table. This should give a dollar amount for each order
in the table.**/
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

/**Find the standard_amt_usd per unit of standard_qty paper. Your solution
should use both an aggregation and a mathematical operator**/

SELECT SUM(standard_amt_usd)/SUM(standard_qty) as standard_unit_price
FROM orders;

/**When was the earliest order ever placed?**/
SELECT MIN(w.occurred_at) as earliest_order_date
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN orders o
ON a.id = o.account_id;

/**performing the same query as in question 1 without using an aggregation
function**/
SELECT w.occurred_at as earliest_order_date
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN orders o
ON a.id = o.account_id
ORDER BY earliest_order_date
LIMIT 1;

/**When did the most recent (latest) web_event occur**/
SELECT MAX(occurred_at) as latest_web_date
FROM web_events;

/**Try to perform the result of the previous query without using an
aggregation function.**/
SELECT occurred_at as latest_web_date
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/**
mean (AVERAGE) amount spent per order on each paper type, as well as the
mean amount of each paper type purchased per order.
**/

SELECT AVG(standard_amt_usd) AS avg_standard_amt_usd,
       AVG(gloss_amt_usd) AS avg_gloss_amt_usd,
       AVG(poster_amt_usd) AS avg_poster_amt_usd,
       AVG(standard_qty) AS avg_standard_qty,
       AVG(gloss_qty) AS avg_gloss_qty,
       AVG(poster_qty) AS avg_poster_qty
FROM orders;

/**
what is the MEDIAN total_usd spent on all orders
**/
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/**
Which account (by name) placed the earliest order?
**/
SELECT a.name, o.occurred_at as earliest_order_date
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY earliest_order_date
LIMIT 1;

/**Find the total sales in usd for each account. **/
SELECT a.name, SUM(total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_usd DESC;

/**
what channel did the most recent (latest) web_event occur, which account was
associated with this web_event?
**/
SELECT latest_web_date, channel, name FROM ((
SELECT account_id, occurred_at as latest_web_date, channel
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1) as t JOIN accounts a ON t.account_id=a.id);

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;
/**
Find the total number of times each type of channel from the web_events was used.
**/

SELECT channel, COUNT(channel) as num_used
FROM web_events
GROUP BY channel
ORDER BY num_used DESC;

/**
Who was the primary contact associated with the earliest web_event
**/

SELECT primary_poc FROM ((
SELECT account_id, occurred_at as latest_web_date
FROM web_events
ORDER BY occurred_at
LIMIT 1) as t JOIN accounts a ON t.account_id=a.id);

SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/**
What was the smallest order placed by each account in terms of total usd.
**/
SELECT a.name, MIN(o.total_amt_usd) AS min_total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

/**
Find the number of sales reps in each region.
**/
SELECT r.name AS region, count(s.id) as num_sales_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY region;

/**
For each account, determine the average amount of each type of paper they
purchased across their orders.
**/
SELECT a.name,
       AVG(o.standard_qty) AS avg_standard_qty,
       AVG(o.gloss_qty) AS avg_gloss_qty,
       AVG(o.poster_qty) AS avg_poster_qty
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name;

/**
For each account, determine the average amount spent per order on each
paper type.
**/
SELECT a.name,
       AVG(o.standard_amt_usd) AS avg_standard_amt_usd,
       AVG(o.gloss_amt_usd) AS avg_gloss_amt_usd,
       AVG(o.poster_amt_usd) AS avg_poster_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name;

/**
Determine the number of times a particular channel was used in the
web_events table for each sales rep.
**/

SELECT s.name reps,w.channel ,COUNT(w.id) num_channel_used
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY (reps, w.channel)
ORDER BY reps,num_channel_used DESC;


/**
Determine the number of times a particular channel was used in the web_events
table for each region.
**/

SELECT r.name region,w.channel ,COUNT(w.id) num_channel_used
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
JOIN region r
ON s.region_id=r.id
GROUP BY (region, w.channel)
ORDER BY region,num_channel_used DESC;

/**
Use DISTINCT to test if there are any accounts associated with more
than one region
**/
SELECT DISTINCT a.name as account_name, r.name as region
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY account_name;

SELECT DISTINCT id, name
FROM accounts;

/**Have any sales reps worked on more than one account?**/
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;


/**ensure all the reps are counted in the previous quert**/
SELECT DISTINCT id, name
FROM sales_reps;

/**
How many of the sales reps have more than 5 accounts that they manage?
**/

SELECT s.name, COUNT(*) as num_of_ac
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s.name
HAVING COUNT(*) >=5;

/*sube query solution*/
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;
/**How many accounts have more than 20 orders?**/

SELECT a.name, COUNT(*) as num_of_order
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY a.name
HAVING COUNT(*)>=20
ORDER BY num_of_order DESC;

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

/**Which account has the most orders**/

SELECT a.name, COUNT(*) as num_of_order
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY a.name
HAVING COUNT(*)>=20
ORDER BY num_of_order DESC
LIMIT 1;


SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

/**Which accounts spent more than 30,000 usd total across all orders**/
SELECT a.name, SUM(total_amt_usd) AS total_sales
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd)>=30000
ORDER BY total_sales DESC;

/**Which accounts spent less than 1,000 usd total across all orders?**/
SELECT a.name, SUM(total_amt_usd) AS total_sales
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd)<1000
ORDER BY total_sales;

/**Which account has spent the most with us**/

SELECT a.id, a.name, SUM(total_amt_usd) AS total_sales
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY a.id, a.name
ORDER BY total_sales DESC
LIMIT 1;

/**Which account has spent the least with us?**/
SELECT a.name, SUM(total_amt_usd) AS total_sales
FROM accounts a
JOIN orders o
ON a.id=o.account_id
GROUP BY a.name
ORDER BY total_sales
LIMIT 1;

/**Which accounts used facebook as a channel to contact customers
 more than 6 times**/

SELECT a.name, COUNT(*) as num_of_use_fb
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE channel='facebook'
GROUP BY a.name
HAVING COUNT(*) >=6
ORDER BY num_of_use_fb DESC;

/*notice the logic*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

/*Which account used facebook most as a channel*/

SELECT a.name, COUNT(*) as num_of_use_fb
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE channel='facebook'
GROUP BY a.name
HAVING COUNT(*) >=6
ORDER BY num_of_use_fb DESC
LIMIT 1;

/*Which channel was most frequently used by most accounts*/

SELECT channel, COUNT(*) as num_of_use
FROM web_events
GROUP BY channel
ORDER BY num_of_use DESC
LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

/*Date*/
/*
Find the sales in terms of total dollars for all orders in each year,
ordered from greatest to least. */

SELECT DATE_PART('year', occurred_at) AS year, SUM(total_amt_usd)
FROM orders
GROUP BY year
ORDER BY SUM(total_amt_usd) DESC;

/*Which month did Parch & Posey have the greatest sales in terms of total
dollars? Are all months evenly represented by the dataset?*/
SELECT DATE_TRUNC('month', occurred_at) AS year_month, SUM(total_amt_usd)
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY year_month
ORDER BY SUM(total_amt_usd) DESC;

/*Which year did Parch & Posey have the greatest sales in terms of total
number of orders? */

SELECT DATE_TRUNC('year', occurred_at) AS year, COUNT(*) AS total_num_orders
FROM orders
GROUP BY year
ORDER BY total_num_orders DESC;

/*
Which month did Parch & Posey have the greatest sales in terms of total
number of orders?
*/
SELECT DATE_TRUNC('month', occurred_at) AS year_month, COUNT(*) AS total_num_orders
FROM orders
GROUP BY year_month
ORDER BY total_num_orders DESC;

SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
/*
In which month of which year did Walmart spend the most on gloss paper in
terms of dollars
*/
SELECT DATE_TRUNC('month', o.occurred_at) AS year_month, SUM(gloss_amt_usd) AS total_amt_gloss
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY year_month
ORDER BY total_amt_gloss DESC
LIMIT 1;

SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

/*
Write a query to display for each order, the account ID, total amount of the
order, and the level of the order - ‘Large’ or ’Small’ - depending on if the
order is $3000 or more, or smaller than $3000.*/

SELECT account_id, total_amt_usd,
       CASE WHEN total_amt_usd>=3000 THEN 'Large' ELSE 'Small' END as level
FROM orders;

/*
Write a query to display the number of orders in each of three categories,
based on the total number of items in each order. The three categories are:
'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
*/
SELECT
       CASE WHEN total>=2000 THEN 'At Least 2000'
            WHEN total>=1000 AND total <2000 THEN 'Between 1000 and 2000'
            ELSE 'Less than 1000' END AS total_quanity_level,
       COUNT(*)
FROM orders
GROUP BY total_quanity_level;

/*customer ltv*/
SELECT a.name as account_name, SUM(o.total_amt_usd) as total_sales_of_all_orders,
       CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000'
            WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN '200,000 and 100,000'
            ELSE 'under 100,000' END as level
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) DESC;


/*customer ltv between 2016 -2017*/
SELECT a.name as account_name, SUM(o.total_amt_usd) as total_sales_of_all_orders,
       CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000'
            WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN '200,000 and 100,000'
            ELSE 'under 100,000' END as level
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE DATE_PART('year',o.occurred_at)=2016 or DATE_PART('year', o.occurred_at) =2017
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) DESC;

SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC;
/*
We would like to identify top performing sales reps, which are sales reps
associated with more than 200 orders.
*/
SELECT s.name AS reps, COUNT(o.id) AS num_of_orders,
      CASE WHEN COUNT(o.id)>=200 THEN 'Top'
           ELSE 'Not' END AS performance_level
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY COUNT(o.id) DESC;

/*dentify top performing sales reps, which are sales reps associated with more
than 200 orders or more than 750000 in total sales. */

SELECT s.name AS reps, COUNT(o.id) AS num_of_orders,
      SUM(total_amt_usd) AS total_sales,
      CASE WHEN COUNT(o.id)>=200 OR SUM(total_amt_usd)>=750000 THEN 'Top'
           WHEN COUNT(o.id)>=150 OR SUM(total_amt_usd)>=500000 THEN 'Middle'
           ELSE 'Low' END AS performance_level
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY total_sales DESC;

/*Subquery*/
SELECT DATE_TRUNC('day', occurred_at) AS day,
	   channel,
       COUNT(*) AS count
FROM web_events
GROUP BY 1,2
ORDER BY count DESC;

SELECT channel, AVG(count)
FROM (SELECT DATE_TRUNC('day', occurred_at) AS day,
	   channel,
       COUNT(*) AS count
FROM web_events
GROUP BY 1,2) sub
GROUP BY channel;


/*Well-formatted Query Examples*/
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
      FROM web_events
      GROUP BY 1,2
      ORDER BY 3 DESC) sub;

SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
      FROM web_events
      GROUP BY 1,2
      ORDER BY 3 DESC) sub
GROUP BY day, channel, events
ORDER BY 2 DESC;


SELECT AVG(standard_qty) AS avg_standard_qty,AVG(gloss_qty) AS avg_gloss_qty,
AVG(poster_qty) AS avg_poster_qty,SUM(total_amt_usd) AS total_usd
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
      (SELECT MIN(DATE_TRUNC('month', occurred_at))
      FROM orders);

/*
Provide the name of the sales_rep in each region with the largest amount
of total_amt_usd sales
*/
SELECT sub_1.region, sub_1.reps, sub_1.total_sales
FROM (
      SELECT r.name AS region, s.name as reps, SUM(o.total_amt_usd) as total_sales
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      JOIN sales_reps s
      ON a.sales_rep_id = s.id
      JOIN region r
      ON s.region_id = r.id
      GROUP BY 1,2) AS sub_1
JOIN
(SELECT region,MAX(total_sales) as total_sales
  FROM (
      SELECT r.name AS region, s.name as reps, SUM(o.total_amt_usd) as total_sales
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      JOIN sales_reps s
      ON a.sales_rep_id = s.id
      JOIN region r
      ON s.region_id = r.id
      GROUP BY 1,2
      ORDER BY 1, 3 DESC
      ) AS sub_2
   GROUP BY region) sub_3
ON sub_1.region = sub_3.region AND sub_1.total_sales = sub_3.total_sales;

/*For the region with the largest (sum) of sales total_amt_usd,
 how many total (count) orders were placed?*/
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
      SELECT MAX(total_amt)
      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
              FROM sales_reps s
              JOIN accounts a
              ON a.sales_rep_id = s.id
              JOIN orders o
              ON o.account_id = a.id
              JOIN region r
              ON r.id = s.region_id
              GROUP BY r.name) sub);
/*
How many accounts had more total purchases than the account name which
has bought the most standard_qty paper throughout their lifetime as a customer?
*/
SELECT COUNT(*)
FROM(
      SELECT a.id, SUM(o.total) as total_purchased
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      GROUP BY 1
      HAVING SUM(o.total)>
      (SELECT SUM(o.standard_qty) AS total_standard_qty
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      GROUP BY a.id
      ORDER BY total_standard_qty DESC
      LIMIT 1)) AS sub;
/*
For the customer that spent the most (in total over their lifetime as a
customer) total_amt_usd, how many web_events did they have for each channel?
*/

SELECT w.account_id, channel, COUNT(*)
FROM web_events w
JOIN(
      SELECT a.id as id, SUM(o.total_amt_usd) as total_purchased
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 1
    ) sub
ON w.account_id = sub.id
GROUP BY 1,2;

/*
What is the lifetime average amount spent in terms of total_amt_usd for the
top 10 total spending accounts?
*/
SELECT o.account_id, AVG(o.total_amt_usd)
FROM orders o
GROUP BY 1
HAVING o.account_id IN (
  SELECT id
  FROM (
        SELECT a.id as id, SUM(o.total_amt_usd) as total_purchased
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 10) AS sub

);
SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;
/*What is the lifetime average amount spent in terms of total_amt_usd,
including only the companies that spent more per order, on average,
than the average of all orders.
*/

SELECT AVG(avg_for_ac_orders)
FROM (
  SELECT account_id, AVG(total_amt_usd) AS avg_for_ac_orders
  FROM orders
  GROUP BY 1
  HAVING AVG(total_amt_usd)>(
    SELECT AVG(total_amt_usd) AS avg_for_all_orders
    FROM orders
  )) AS sub;

SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                   FROM orders o)) temp_table;
