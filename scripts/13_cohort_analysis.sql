-- Let’s identify the customer's first purchase which wilil be his first cohort month. Create a view “v_customer_first_purchase”
CREATE OR REPLACE VIEW ecommerce_db.v_customer_first_purchase AS
SELECT CustomerID,MIN(CAST(InvoiceDate AS DATE)) AS cohort_month FROM ecommerce_db.base_data
GROUP BY CustomerID;

-- a view “v_customer_monthly_activity” to identify the months where customers are active
CREATE OR REPLACE VIEW ecommerce_db.v_customer_monthly_activity AS
SELECT DISTINCT CustomerID ,MonthStart AS activity_month FROM ecommerce_db.base_data;

-- Let us try to understand the cohort activity. Basically we want to each active month to how many months it is after the cohort month
CREATE OR REPLACE VIEW ecommerce_db.v_customer_cohort_activity AS
SELECT DISTINCT m.CustomerID ,f.cohort_month ,m.activity_month,
TIMESTAMPDIFF(MONTH,f.cohort_month,m.activity_month) AS cohort_index FROM ecommerce_db.v_customer_first_purchase f
JOIN ecommerce_db.v_customer_monthly_activity m ON f.CustomerID=m.CustomerID;


-- Let us try to find the total customers in each cohort size
CREATE OR REPLACE VIEW ecommerce_db.v_cohort_size AS
SELECT cohort_month,COUNT(DISTINCT CustomerID) AS cohort_size FROM ecommerce_db.v_customer_cohort_activity
GROUP BY cohort_month;


-- Which month has the highest number of customers?
SELECT * FROM ecommerce_db.v_cohort_size ORDER BY cohort_size desc;


-- Let us try to find how many customers from each cohort returned in month 0, 1, 2, etc.
-- Create a view “v_cohort_retention_counts”
CREATE OR REPLACE VIEW ecommerce_db.v_cohort_retention_counts AS
SELECT cohort_month,cohort_index,COUNT(DISTINCT CustomerID) AS retained_customers FROM ecommerce_db.v_customer_cohort_activity
GROUP BY cohort_month,cohort_index;


-- Now we would like find out cohort retention percentages
CREATE OR REPLACE VIEW ecommerce_db.v_cohort_retention_pct AS
SELECT r.cohort_month,r.cohort_index,s.cohort_size,r.retained_customers,
ROUND(r.retained_customers*100/s.cohort_size,2) AS retention_pct
 FROM ecommerce_db.v_cohort_size s 
JOIN ecommerce_db.v_cohort_retention_counts r ON s.cohort_month=r.cohort_month;
