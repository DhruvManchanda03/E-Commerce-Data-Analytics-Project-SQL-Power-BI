-- removing Dec 2011 rows because of incomplete data

TRUNCATE TABLE  ecommerce_db.base_data;

INSERT INTO ecommerce_db.base_data(
id,
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
id,
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
FROM ecommerce_db.ecommerce_cleaned
WHERE InvoiceDate<'2011-12-01';