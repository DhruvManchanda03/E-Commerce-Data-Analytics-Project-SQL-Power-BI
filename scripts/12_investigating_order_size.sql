-- create a one row per invoice to understand the order size. Create a view “v_order_metrics” to capture this
CREATE OR REPLACE VIEW ecommerce_db.v_order_metrics AS
SELECT InvoiceNo,MIN(InvoiceDate) AS InvoiceDate,MIN(MonthStart) AS month_start,MIN(QuarterStart) AS QuarterStart,MIN(YearNum) as year_num,
COUNT(DISTINCT StockCode) AS unique_products,SUM(Revenue) AS order_value,SUM(Quantity) AS item_per_order,AVG(UnitPrice) AS 
avg_unit_price FROM ecommerce_db.base_data GROUP BY InvoiceNo;

-- invoice has the highest number of unique products
SELECT * FROM ecommerce_db.v_order_metrics ORDER BY unique_products desc;

-- a view “v_monthly_average_order_value” to calculate the average monthly order value
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_average_order_value AS
SELECT month_start,YEAR(month_start) AS year_num,MONTH(month_start) AS month_num,MONTHNAME(month_start) AS month_name,
ROUND(AVG(order_value),2) AS avg_order_value FROM ecommerce_db.v_order_metrics GROUP BY
month_start,YEAR(month_start),MONTH(month_start),MONTHNAME(month_start);

-- Let’s try to find MoM average order value to understand the growth and decline percentage
-- Create a view “v_monthly_average_order_value_mom”
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_average_order_value_mom AS
SELECT month_start,year_num,month_num,month_name,
avg_order_value,
LAG(avg_order_value) OVER(ORDER BY month_start) AS PreviousMonthValue,
ROUND((avg_order_value - LAG(avg_order_value) OVER(ORDER BY month_start))*100/
NULLIF(LAG(avg_order_value) OVER(ORDER BY month_start),0),2) AS MoM_avg_order_value_growth_pct
 FROM ecommerce_db.v_monthly_average_order_value