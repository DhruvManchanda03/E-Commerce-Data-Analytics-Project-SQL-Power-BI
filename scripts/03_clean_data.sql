DROP TABLE IF EXISTS ecommerce_db.ecommerce_cleaned;

create table ecommerce_db.ecommerce_cleaned(
id BIGINT AUTO_INCREMENT PRIMARY KEY,
InvoiceNo VARCHAR(25),
StockCode VARCHAR(25),
Description TEXT NULL,
Quantity INT,
InvoiceDate DATETIME,
UnitPrice DECIMAL(10,2),
CustomerID BIGINT NULL,
Country VARCHAR(30),
Revenue DECIMAL(10,2)
);
INSERT INTO ecommerce_db.ecommerce_cleaned(
InvoiceNo,
StockCode,
Description,
Quantity,
InvoiceDate,
UnitPrice,
CustomerID,
Country,
Revenue )

SELECT 
InvoiceNo,
StockCode,
Description,
Quantity,
STR_TO_DATE(InvoiceDate ,' %m/%d/%Y %H:%i'),
UnitPrice,
CustomerID,
Country,
UnitPrice*Quantity
FROM ecommerce_db.ecommerce_staging
WHERE CustomerID IS NOT NULL and CustomerID!=0
and InvoiceNo NOT LIKE 'C%' and Quantity>0 and UnitPrice>0;