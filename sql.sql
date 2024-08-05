/*Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset*/
/*1.Data type of all columns in the "customers" table*/
SELECT column_name,data_type FROM `target_dataset.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers'
/*2.Get the time range between which the orders were placed:*/
select min(order_purchase_timestamp) as start_date,max(order_purchase_timestamp) as end_date,date_diff(
max(order_purchase_timestamp),min(order_purchase_timestamp),day) as time_span from`target.orders`