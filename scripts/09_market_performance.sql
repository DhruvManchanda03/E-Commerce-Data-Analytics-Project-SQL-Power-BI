-- Create a view v_country_total_revenue to find how much revenue each country is contributing
CREATE OR REPLACE VIEW ecommerce_db.v_country_total_revenue AS
SELECT Country,SUM(Revenue) as TotalRevenue FROM ecommerce_db.base_data
GROUP BY Country;

-- Which are the top 5 countries that are contributing highest revenue
SELECT * FROM ecommerce_db.v_country_total_revenue
ORDER BY TotalRevenue desc LIMIT 5;

-- How much Saudi Arabia is contributing to the revenue
SELECT * FROM ecommerce_db.v_country_total_revenue
WHERE Country='Saudi Arabia';

-- Create a view v_country_revenue_share where we would like to find how much percentage each country is contributing to the total revenue?
CREATE OR REPLACE VIEW ecommerce_db.v_country_revenue_share AS
SELECT Country,TotalRevenue,
ROUND(TotalRevenue*100/SUM(TotalRevenue) OVER(),2) AS revenue_share_pct
 FROM ecommerce_db.v_country_total_revenue
GROUP BY Country;

-- Create a view v_country_monthly_revenue to identify monthly revenue by country?
CREATE OR REPLACE VIEW ecommerce_db.v_country_monthly_revenue AS
SELECT Country,MonthStart,YEAR(MonthStart) AS YearNum,MONTH(MonthStart) AS MonthNum,MONTHNAME(MonthStart) AS MonthName,
SUM(Revenue) AS TotalRevenue FROM ecommerce_db.base_data GROUP BY Country,MonthStart,YearNum,MonthNum,MonthName;


-- Create a view v_country_mom_revenue to identify the month on month growth or decline for each of the market
CREATE OR REPLACE VIEW ecommerce_db.v_country_mom_revenue AS
SELECT Country,MonthStart,YearNum,MonthNum,MonthName,
TotalRevenue ,
LAG(TotalRevenue) OVER(PARTITION BY Country ORDER BY MonthStart) AS PreviousMonth,
ROUND((TotalRevenue-LAG(TotalRevenue) OVER(PARTITION BY Country ORDER BY MonthStart))*100/
NULLIF(LAG(TotalRevenue) OVER(PARTITION BY Country ORDER BY MonthStart ),0),2) AS MoM_growth_pct
FROM ecommerce_db.v_country_monthly_revenue;


-- Since the UK contributes the majority of total revenue
SELECT * FROM ecommerce_db.v_country_mom_revenue
WHERE Country='United Kingdom';


-- Create a view v_country_quarterly_revenue to identity the quarterly revenue, and then we will identify QoQ
CREATE OR REPLACE VIEW ecommerce_db.v_country_quarterly_revenue AS
SELECT Country,QuarterStart,YEAR(QuarterStart) AS YearNum,QUARTER(QuarterStart) AS QuarterNum,
SUM(Revenue) AS TotalRevenue FROM ecommerce_db.base_data GROUP BY Country,QuarterStart,YearNum,QuarterNum;


-- Identify the QoQ growth .Create a view by name v_country_qoq_revenue
CREATE OR REPLACE VIEW ecommerce_db.v_country_qoq_revenue AS
SELECT Country,QuarterStart,YearNum,QuarterNum,
TotalRevenue ,
LAG(TotalRevenue) OVER(PARTITION BY Country ORDER BY QuarterStart) AS PreviousQuarter,
ROUND((TotalRevenue-LAG(TotalRevenue) OVER(PARTITION BY Country ORDER BY QuarterStart))*100/
NULLIF(LAG(TotalRevenue) OVER(PARTITION BY Country ORDER BY QuarterStart ),0),2) AS QoQ_growth_pct
FROM ecommerce_db.v_country_quarterly_revenue;

-- Identify the top 5 countries that contributes to the revenue: (Create a view v_top_5_countries_revenue)
SELECT Country,TotalRevenue,revenue_share_pct FROM(
SELECT Country,TotalRevenue,revenue_share_pct,
ROW_NUMBER() OVER(ORDER BY TotalRevenue desc) as rn
FROM ecommerce_db.v_country_revenue_share)t
WHERE rn<=5;