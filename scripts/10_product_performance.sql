-- Create a  view by name v_product_total_revenue, that would show us the highest generating revenue products
CREATE OR REPLACE VIEW ecommerce_db.v_product_total_revenue AS
SELECT StockCode,Description,SUM(Revenue) AS total_revenue
FROM ecommerce_db.base_data GROUP BY StockCode,Description;

-- What are the top 5 highest generating revenue products?
SELECT StockCode,Description,total_revenue 
FROM ecommerce_db.v_product_total_revenue ORDER BY total_revenue desc; 


-- Create a view by name  v_product_revenue_share to understand how each product is contributing to the total revenue
CREATE OR REPLACE VIEW ecommerce_db.v_product_revenue_share AS
SELECT StockCode,Description,total_revenue,
ROUND(total_revenue*100/SUM(total_revenue) OVER(),2) AS revenue_share_pct
FROM ecommerce_db.v_product_total_revenue;

-- Get the top 10 highest revenue generating products
SELECT * FROM ecommerce_db.v_product_revenue_share ORDER BY revenue_share_pct desc LIMIT 10;


-- Create a view by name v_product_monthly_revenue to understand the product revenue on monthly basis
CREATE OR REPLACE VIEW ecommerce_db.v_product_monthly_revenue AS
SELECT StockCode,Description,MonthStart,YearNum, MONTH(MonthStart) AS month_num,MONTHNAME(MonthStart) AS month_name,SUM(Revenue) AS net_revenue
FROM ecommerce_db.base_data GROUP BY StockCode,Description,MonthStart,YearNum,MONTH(MonthStart),MONTHNAME(MonthStart);


-- Which product has the highest revenue and in which month?
SELECT StockCode,Description,MonthStart,month_name,net_revenue 
FROM ecommerce_db.v_product_monthly_revenue ORDER BY net_revenue desc;


-- Create a view by name v_product_mom_revenue which would give us the revenue growth or decline month on month basis
CREATE OR REPLACE VIEW ecommerce_db.v_product_mom_revenue AS
SELECT StockCode,Description,MonthStart,YearNum,month_num,month_name,net_revenue,
LAG(net_revenue) OVER(PARTITION BY StockCode,Description ORDER BY MonthStart) AS PreviousMonthRevenue,
ROUND((net_revenue - LAG(net_revenue) OVER(PARTITION BY StockCode,Description ORDER BY MonthStart)) *100/
NULLIF(LAG(net_revenue) OVER(PARTITION BY StockCode,Description ORDER BY MonthStart),0),2) AS MoM_growth_pct
FROM ecommerce_db.v_product_monthly_revenue;


-- Which all months are declining months where mom_growth_pct is less than 0;
SELECT * FROM ecommerce_db.v_product_mom_revenue
WHERE MoM_growth_pct<0 ORDER BY StockCode,MonthStart;

-- What is the revenue trend of the product “REGENCY CAKESTAND 3 TIER” ?
SELECT * FROM ecommerce_db.v_product_mom_revenue
WHERE Description="REGENCY CAKESTAND 3 TIER";


-- Create a view by name v_product_quarterly_revenue where we would like to see the product trend based on quarter
CREATE OR REPLACE VIEW ecommerce_db.v_product_quarterly_revenue AS
SELECT StockCode,Description,QuarterStart,YearNum,Quarter(QuarterStart) AS quarter_num,SUM(Revenue) AS net_revenue
FROM ecommerce_db.base_data GROUP BY StockCode,Description,QuarterStart,YearNum,Quarter(QuarterStart);


-- Create a view by name v_product_qoq_revenue to check the product growth or decline percentage based on quarter
CREATE OR REPLACE VIEW ecommerce_db.v_product_qoq_revenue AS
SELECT StockCode,Description,QuarterStart,YearNum,quarter_num,net_revenue,
LAG(net_revenue) OVER(PARTITION BY StockCode,Description ORDER BY QuarterStart) AS PreviousQuarterRevenue,
ROUND((net_revenue - LAG(net_revenue) OVER(PARTITION BY StockCode,Description ORDER BY QuarterStart)) *100/
NULLIF(LAG(net_revenue) OVER(PARTITION BY StockCode,Description ORDER BY QuarterStart),0),2) AS QoQ_growth_pct
FROM ecommerce_db.v_product_quarterly_revenue;

-- How the product “REGENCY CAKESTAND 3 TIER” is behaving quarter on quarter
SELECT * FROM ecommerce_db.v_product_qoq_revenue
WHERE Description="REGENCY CAKESTAND 3 TIER";