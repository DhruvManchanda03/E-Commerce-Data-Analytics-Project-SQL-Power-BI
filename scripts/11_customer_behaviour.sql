-- a view v_unique_customers to get the count of unique customer
CREATE OR REPLACE VIEW ecommerce_db.v_unique_customers AS
SELECT COUNT(DISTINCT CustomerID) AS unique_customers FROM ecommerce_db.base_data;

-- a view “v_monthly_unique_customers” that would track whether the active customer base is changing over time
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_unique_customers AS
SELECT MonthStart,YearNum, MONTH(MonthStart) AS month_num,MONTHNAME(MonthStart) AS month_name,COUNT(DISTINCT CustomerID) AS unique_customers
FROM ecommerce_db.base_data
GROUP BY MonthStart,YearNum, MONTH(MonthStart),MONTHNAME(MonthStart);
 
 
 --  month that has more number of unique customer
 SELECT * FROM ecommerce_db.v_monthly_unique_customers
 ORDER BY unique_customers desc;

-- “v_monthly_unique_customers_mom” to see the unique customer month on month basis
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_unique_customers_mom AS
SELECT MonthStart,YearNum,month_num,month_name,unique_customers,
LAG(unique_customers) OVER(ORDER BY MonthStart) AS PreviousMonthCustomers,
ROUND((unique_customers- LAG(unique_customers) OVER(ORDER BY MonthStart))*100/
NULLIF(LAG(unique_customers) OVER(ORDER BY MonthStart),0),2) AS MoM_customer_growth_pct
FROM ecommerce_db.v_monthly_unique_customers;


-- a view v_customer_purchase_frequency that would fetch us the customer purchase frequency
CREATE OR REPLACE VIEW ecommerce_db.v_customer_purchase_frequency AS
SELECT CustomerID,COUNT(DISTINCT InvoiceNo) AS total_orders,SUM(Revenue) AS total_revenue,
ROUND(SUM(Revenue)/NULLIF(COUNT(DISTINCT InvoiceNo),0),2) AS avg_revenue_per_order FROM ecommerce_db.base_data
GROUP BY CustomerID;


-- customer id with the highest revenue
SELECT * FROM ecommerce_db.v_customer_purchase_frequency ORDER BY total_revenue desc LIMIT 1;

-- Create a view “v_repeat_customers_summary” which would give us idea of whether the customers are repeating or not.
-- A repeat customer is the one who has more than one distinct invoice
CREATE OR REPLACE VIEW ecommerce_db.v_repeat_customers_summary AS
SELECT CustomerID,COUNT(DISTINCT InvoiceNo) as total_orders FROM ecommerce_db.base_data
WHERE CustomerID IS NOT NULL GROUP BY CustomerID HAVING total_orders>1;


-- How many repeat customers are there
SELECT COUNT(*) FROM ecommerce_db.v_repeat_customers_summary;

-- a view “v_monthly_repeat_customers” which would give us an indication about repeat customer monthly
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_repeat_customers AS
SELECT MonthStart,MONTH(MonthStart) AS month_num,MONTHNAME(MonthStart) AS month_name,YEAR(MonthStart) AS YearNum ,
COUNT(*) AS repeat_customers FROM(
SELECT CustomerID,MonthStart,COUNT(DISTINCT InvoiceNo) as total_orders FROM ecommerce_db.base_data
GROUP BY MonthStart,CustomerID HAVING total_orders>1)t GROUP BY
MonthStart,MONTH(MonthStart),MONTHNAME(MonthStart),YEAR(MonthStart);

-- a view v_monthly_repeat_customers_mom, to understand the repeat customer month on month growth
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_repeat_customers_mom AS
SELECT MonthStart,YearNum,month_num,month_name,repeat_customers,
LAG(repeat_customers) OVER(ORDER BY MonthStart) AS PreviousMonthCustomers,
ROUND((repeat_customers- LAG(repeat_customers) OVER(ORDER BY MonthStart))*100/
NULLIF(LAG(repeat_customers) OVER(ORDER BY MonthStart),0),2) AS MoM_repeat_customer_growth_pct
FROM ecommerce_db.v_monthly_repeat_customers;


-- a view of v_top_10_high_value_customers for high-value customers, which are defined as the top 10 by total revenue.
CREATE OR REPLACE VIEW ecommerce_db.v_top_10_high_value_customers AS
SELECT * FROM ecommerce_db.v_customer_purchase_frequency
ORDER BY total_revenue DESC LIMIT 10;

-- take the top-10 customer from our previous view and create a view “v_high_value_customer_monthly_revenue”  to determine if the high value customers are buying less
CREATE OR REPLACE VIEW ecommerce_db.v_high_value_customer_monthly_revenue AS
SELECT  b.CustomerID,b.MonthStart,b.YearNum,MONTH( b.MonthStart) AS month_num, MONTHNAME( b.MonthStart) AS month_name ,
SUM(b.Revenue) AS net_revenue
FROM ecommerce_db.v_top_10_high_value_customers h
JOIN ecommerce_db.base_data b ON h.CustomerID=b.CustomerID
GROUP BY b.CustomerID,b.MonthStart,b.YearNum,MONTH( b.MonthStart),MONTHNAME( b.MonthStart);

-- is there any pattern, take one customer id and check?
SELECT * FROM ecommerce_db.v_high_value_customer_monthly_revenue WHERE CustomerID=14911;



-- try to find the high value customer trend month on month basic. Create a view “v_high_value_customer_mom_revenue”
CREATE OR REPLACE VIEW ecommerce_db.v_high_value_customer_mom_revenue AS
SELECT CustomerID,MonthStart,YearNum,month_num,month_name,net_revenue,
LAG(net_revenue) OVER(PARTITION BY CustomerId ORDER BY MonthStart) AS PreviousMonthRevenue,
ROUND((net_revenue-LAG(net_revenue) OVER(PARTITION BY CustomerId ORDER BY MonthStart))*100/
NULLIF(LAG(net_revenue) OVER(PARTITION BY CustomerId ORDER BY MonthStart),0),2) AS MoM_growth_pct
FROM ecommerce_db.v_high_value_customer_monthly_revenue;


-- Are there any declines?
SELECT * FROM ecommerce_db.v_high_value_customer_mom_revenue 
WHERE MoM_growth_pct<0;

-- Which month is showing the highest decline?
SELECT YearNum,MonthStart,month_num,month_name,COUNT(*)
FROM ecommerce_db.v_high_value_customer_mom_revenue  WHERE MoM_growth_pct<0
GROUP BY YearNum,MonthStart,month_num,month_name;

