/*Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset*/
/*1.Data type of all columns in the "customers" table*/
SELECT column_name,data_type FROM `target_dataset.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers'
/*2.Get the time range between which the orders were placed:*/
select min(order_purchase_timestamp) as start_date,max(order_purchase_timestamp) as end_date,date_diff(
max(order_purchase_timestamp),min(order_purchase_timestamp),day) as time_span from`target.orders`
/*3.Count the Cities & States of customers who ordered during the given period:*/
select count(distinct customer_city) as cities,count(distinct customer_state) as states
from `target.customers` c join `target.orders` o on c.customer_id=o.customer_id
/*4.growing trend in the no. of orders placed over the past years*/
select extract(year from order_purchase_timestamp) as year, count(order_id) as num_order
from `target.orders`
group by extract(year from order_purchase_timestamp)order by num_order
/*5.monthly seasonality in terms of the no. of orders being placed?*/
select format_timestamp('%Y-%m',order_purchase_timestamp) as
year_month,count(order_id) as num_order
from `target.orders`
group by year_month
order by year_month
/*6.During what time of the day, do the Brazilian customers mostly place their orders:
(Dawn, Morning, Afternoon or Night)
o 0-6 hrs : Dawn
o 7-12 hrs : Mornings
o 13-18 hrs : Afternoon
o 19-23 hrs : Night*/
SELECT
CASE
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 6
THEN 'Dawn'
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 7 AND 12
THEN 'Morning'
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 13 AND 18
THEN 'Afternoon'
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 19 AND 23
THEN 'Night'
END AS time_of_day,
COUNT(order_id) AS num_orders
FROM
`target.orders`
GROUP BY
CASE
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 6
THEN 'Dawn'
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 7 AND 12
THEN 'Morning'
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 13 AND 18
THEN 'Afternoon'
WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 19 AND 23
THEN 'Night'
END
ORDER BY
num_orders DESC

