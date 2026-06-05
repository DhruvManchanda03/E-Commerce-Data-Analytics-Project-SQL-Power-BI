-- checking if loaded correctly
SELECT * FROM ecommerce_db.base_data where InvoiceDate>'2011-12-01';

-- Now how does the month on month trend looks like towards the end of year 2011
SELECT * FROM ecommerce_db.v_month_on_month_revenue;

-- Create a view v_quarter_on_quarter_revenue  to find how the revenue is trending quarter on quarter
CREATE OR REPLACE VIEW ecommerce_db.v_quarter_on_quarter_revenue AS
WITH quarterly AS (
SELECT QuarterStart,YearNum,QuarterNum,NetRevenue,
LAG(NetRevenue) OVER (ORDER BY QuarterStart) AS PreviousQuarterRevenue
FROM ecommerce_db.v_quarterly_net_revenue
)
SELECT QuarterStart, YearNum,QuarterNum,NetRevenue,PreviousQuarterRevenue,
ROUND((NetRevenue - PreviousQuarterRevenue)*100/ NULLIF(PreviousQuarterRevenue, 0) ,2) AS QoQGrowthPct
FROM quarterly;

-- Create a view v_year_on_year_revenue to identify the revenue trend  by year
CREATE OR REPLACE VIEW ecommerce_db.v_year_on_year_revenue AS
WITH yearly AS (
SELECT YearNum,NetRevenue,LAG(NetRevenue) OVER (ORDER BY YearNum) AS PreviousYearRevenue
FROM ecommerce_db.v_yearly_net_revenue
)
SELECT
YearNum,NetRevenue,PreviousYearRevenue,
ROUND((NetRevenue - PreviousYearRevenue)*100/ NULLIF(PreviousYearRevenue, 0) ,2) AS YoYGrowthPct FROM yearly;