SELECT * FROM ecommerce_db.ecommerce_cleaned;

-- What is the total number of rows in the cleaned table?
SELECT COUNT(*) FROM ecommerce_db.ecommerce_cleaned;

-- What is the difference of rows between original and cleaned tables?
SELECT 
(SELECT COUNT(*) FROM ecommerce_db.ecommerce_staging) -
(SELECT COUNT(*) FROM ecommerce_db.ecommerce_cleaned) as row_difference;

-- Are there any rows with quantities less than 0?
SELECT count(*) FROM ecommerce_db.ecommerce_cleaned
WHERE Quantity<0 or UnitPrice=0;

-- What is the minimum and maximum date ?
SELECT MIN(DATE(InvoiceDate)) as min_date,
MAX(DATE(InvoiceDate)) as max_date FROM ecommerce_db.ecommerce_cleaned;


-- For how many dates, the data is not present
SELECT
    DATEDIFF(
	MAX(DATE(InvoiceDate)),MIN(DATE(InvoiceDate))) + 1 AS total_dates,
	COUNT(DISTINCT DATE(InvoiceDate)) AS dates_with_data,
    ( DATEDIFF(MAX(DATE(InvoiceDate)),MIN(DATE(InvoiceDate))) + 1
	-COUNT(DISTINCT DATE(InvoiceDate)))
          AS missing_dates FROM ecommerce_db.ecommerce_cleaned;

