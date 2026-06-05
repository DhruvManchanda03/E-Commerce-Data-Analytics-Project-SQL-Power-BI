SELECT * FROM ecommerce_db.base_data;


-- Create a view by name v_monthly_net_revenue to fetch the net revenue across months of different years
CREATE OR REPLACE VIEW ecommerce_db.v_monthly_net_revenue AS
SELECT MonthStart,YEAR(MonthStart) as YearNum,MONTH(MonthStart) as Month,MONTHNAME(MonthStart) as MonthName,SUM(Revenue) as NetRevenue FROM ecommerce_db.base_data
GROUP BY MonthStart,YEAR(MonthStart),MONTH(MonthStart),MONTHNAME(MonthStart);

-- Which year’s month has maximum monthly net revenue?
SELECT MonthStart,YEAR(MonthStart),MONTH(MonthStart),MONTHNAME(MonthStart),NetRevenue
FROM ecommerce_db.v_monthly_net_revenue ORDER BY NetRevenue desc ;

-- Which year’s month has minimum monthly net revenue?
SELECT MonthStart,YEAR(MonthStart),MONTH(MonthStart),MONTHNAME(MonthStart),NetRevenue
FROM ecommerce_db.v_monthly_net_revenue ORDER BY NetRevenue;


-- Create a view by name v_quarterly_net_revenue for finding the revenue by each year quarter
CREATE OR REPLACE VIEW ecommerce_db.v_quarterly_net_revenue AS
SELECT QuarterStart,YEAR(QuarterStart) as YearNum,QUARTER(QuarterStart) as QuarterNum,SUM(Revenue) as NetRevenue FROM ecommerce_db.base_data
GROUP BY QuarterStart,YearNum,QuarterNum;


-- Which quarter has the maximum revenue?
SELECT QuarterStart,YEAR(QuarterStart),QUARTER(QuarterStart),NetRevenue
FROM ecommerce_db.v_quarterly_net_revenue ORDER BY NetRevenue desc ;


-- Which month has the least revenue?
SELECT MonthStart,YEAR(MonthStart),MONTH(MonthStart),MONTHNAME(MonthStart),NetRevenue
FROM ecommerce_db.v_monthly_net_revenue ORDER BY NetRevenue;

-- Create a view v_yearly_net_revenue to find the yearly net revenue?
CREATE OR REPLACE VIEW ecommerce_db.v_yearly_net_revenue AS
SELECT YearNum,SUM(Revenue) as NetRevenue FROM ecommerce_db.base_data
GROUP BY YearNum;

-- Which year has maximum net revenue?
SELECT * FROM ecommerce_db.v_yearly_net_revenue 
ORDER BY NetRevenue desc;

-- Create a view v_month_on_month_revenue to find the revenue decrease or increase percentage month on month
CREATE OR REPLACE VIEW ecommerce_db.v_month_on_month_revenue AS
WITH monthly AS (
    SELECT MonthStart,YearNum,Month,MonthName,NetRevenue,
	LAG(NetRevenue) OVER (ORDER BY MonthStart) AS PreviousMonthRevenue
    FROM ecommerce_db.v_monthly_net_revenue
)
SELECT
    MonthStart, YearNum,Month,MonthName,NetRevenue,PreviousMonthRevenue,
    ROUND((NetRevenue - PreviousMonthRevenue)/ NULLIF(PreviousMonthRevenue, 0) * 100,2) AS MoMGrowthPct
FROM monthly;
