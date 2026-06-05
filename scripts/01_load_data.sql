SET GLOBAL local_infile = 1;

create database ecommerce_db;

DROP TABLE IF EXISTS ecommerce_db.ecommerce_staging;

create table ecommerce_db.ecommerce_staging(
InvoiceNo VARCHAR(25),
StockCode VARCHAR(25),
Description TEXT NULL,
Quantity INT,
InvoiceDate VARCHAR(30),
UnitPrice DECIMAL(10,2),
CustomerID BIGINT NULL,
Country VARCHAR(30)
);

-- Load the data into the staging table:

LOAD DATA LOCAL INFILE 'C:/Users/dmanc/Desktop/Project/data.csv'
INTO TABLE ecommerce_db.ecommerce_staging
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country);
