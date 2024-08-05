/*Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset*/
/*1.Data type of all columns in the "customers" table*/
SELECT column_name,data_type FROM `target_dataset.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers'