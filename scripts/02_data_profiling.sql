-- selecting the table
SELECT * FROM ecommerce_db.ecommerce_staging;


--  What is the total number of rows?
SELECT COUNT(*) FROM ecommerce_db.ecommerce_staging;


-- Total number of rows with zero quantity
SELECT COUNT(Quantity) FROM ecommerce_db.ecommerce_staging where Quantity=0;


-- Total number of rows with negative quantity
SELECT COUNT(Quantity) FROM ecommerce_db.ecommerce_staging where Quantity<0;


-- Total rows with zero unit price
SELECT COUNT(*) FROM ecommerce_db.ecommerce_staging where UnitPrice=0;


-- Total customer with blank or empty Ids
SELECT COUNT(CustomerID) FROM ecommerce_db.ecommerce_staging where CustomerID=" ";


-- duplicate invoices
SELECT InvoiceNo,COUNT(InvoiceNo) as Count FROM ecommerce_db.ecommerce_staging
GROUP BY InvoiceNO HAVING Count>1 ;

-- How many duplicate invoices are present
SELECT COUNT(*) FROM (
SELECT InvoiceNo,COUNT(InvoiceNo) as Count FROM ecommerce_db.ecommerce_staging
GROUP BY InvoiceNO HAVING Count>1)t ;

-- Which invoice number has appeared most?
SELECT InvoiceNo,COUNT(InvoiceNo) as Count FROM ecommerce_db.ecommerce_staging
GROUP BY InvoiceNO HAVING Count>1 ORDER BY Count DESC LIMIT 1;

-- How many customer id who have purchased only once?
SELECT COUNT(*) FROM(
SELECT CustomerId,COUNT(CustomerID) as Count FROM ecommerce_db.ecommerce_staging
GROUP BY CustomerID HAVING Count=1)t;

-- Which customer Id has generated the most  number of invoices? Exclude the customer id with 0 
SELECT CustomerId,COUNT(CustomerId) as Count FROM ecommerce_db.ecommerce_staging WHERE CustomerID!=0
GROUP BY CustomerID ORDER BY Count desc LIMIT 1;

-- How many cancelled 
SELECT COUNT(InvoiceNo) FROM ecommerce_db.ecommerce_staging WHERE InvoiceNo LIKE 'C%';

-- From which country highest number of invoices is generated
SELECT Country,COUNT(InvoiceNo) as Count FROM ecommerce_db.ecommerce_staging GROUP BY Country
ORDER BY Count desc;

-- Which country has less number of invoices
SELECT Country,COUNT(InvoiceNo) as Count FROM ecommerce_db.ecommerce_staging GROUP BY Country
ORDER BY Count;

-- Which country has maximum number of blank customer ids
SELECT Country,COUNT(CustomerID) as Count FROM ecommerce_db.ecommerce_staging WHERE CustomerID=" "
GROUP BY Country ORDER BY Count desc;
