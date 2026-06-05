-- Since further investigation requires time frame, so lets derive, year, quarter and month field from the date column. 


DROP TABLE IF EXISTS ecommerce_db.base_data;

create table ecommerce_db.base_data(
id BIGINT AUTO_INCREMENT PRIMARY KEY,
InvoiceNo VARCHAR(25),
StockCode VARCHAR(25),
Description TEXT NULL,
Quantity INT,
InvoiceDate DATETIME,
UnitPrice DECIMAL(10,2),
CustomerID BIGINT NULL,
Country VARCHAR(30),
Revenue DECIMAL(10,2),
MonthStart DATE,
QuarterStart DATE,
YearNum INT 
);
INSERT INTO ecommerce_db.base_data(
InvoiceNo,
StockCode,
Description,
Quantity,
InvoiceDate,
UnitPrice,
CustomerID,
Country,
Revenue ,
MonthStart,
QuarterStart,
YearNum
)

SELECT 
InvoiceNo,
StockCode,
Description,
Quantity,
InvoiceDate,
UnitPrice,
CustomerID,
Country,
UnitPrice*Quantity,
CAST(DATE_FORMAT(InvoiceDate,'%Y-%m-1') as DATE),
DATE_ADD(
    MAKEDATE(YEAR(InvoiceDate), 1),
    INTERVAL (QUARTER(InvoiceDate)-1)*3 MONTH
),
YEAR(InvoiceDate)
FROM ecommerce_db.ecommerce_cleaned;