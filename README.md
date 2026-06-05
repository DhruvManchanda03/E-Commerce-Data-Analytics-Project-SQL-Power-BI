# 📊 E-Commerce Revenue Decline Investigation using SQL & Power BI

## 📌 Project Overview

This project is a data analysis and business intelligence case study completed for learning and portfolio development purposes. The objective was to investigate a scenario where an e-commerce company experiences declining revenue despite increased business investments.

Using SQL and Power BI, I performed an end-to-end analysis covering revenue trends, customer behavior, product performance, market performance, customer retention, and order patterns to identify potential causes of revenue leakage and generate actionable business insights.

---

## 🎯 Business Problem

An e-commerce company is facing declining revenue over multiple periods despite increasing investments in business growth initiatives.

The analysis aims to answer the following questions:

- Why is revenue declining?
- Which markets contribute most to revenue performance?
- Are specific products underperforming?
- Has customer purchasing behavior changed?
- Are repeat purchases decreasing?
- Is customer retention weakening?
- Are average order values declining?
- What factors are contributing to revenue leakage?

---

## 📂 Dataset

This project uses the **Online Retail Dataset** obtained from Kaggle.

The dataset contains over 500,000 transactional records from a UK-based online retail company and includes customer, product, sales, and geographic information.

**Source:**  
https://www.kaggle.com/datasets/carrie1/ecommerce-data

### Dataset Features

| Column | Description |
|----------|-------------|
| InvoiceNo | Transaction ID |
| StockCode | Product ID |
| Description | Product Name |
| Quantity | Units Purchased |
| InvoiceDate | Transaction Date |
| UnitPrice | Price Per Unit |
| CustomerID | Customer Identifier |
| Country | Customer Country |

---

## 🛠️ Tools & Technologies

- MySQL
- Power BI
- SQL Window Functions
- Data Cleaning & Transformation
- Business Intelligence
- Cohort Analysis
- Data Visualization

---

## 🧠 Skills Demonstrated

- SQL Query Writing
- Data Cleaning
- Data Transformation
- Window Functions
- KPI Development
- Business Analytics
- Customer Analytics
- Product Analytics
- Cohort Analysis
- Customer Retention Analysis
- Dashboard Development
- Data Storytelling
- Power BI Reporting

---

## 📁 Project Structure

```text
Dataset/
SQL Scripts/
│
├── Data Cleaning
├── Revenue Analysis
├── Market Analysis
├── Product Analysis
├── Customer Analysis
├── Cohort Analysis
└── Order Analysis

Power BI Dashboard/
README.md
```

---

## 🔄 Project Workflow

### 1. Data Preparation

Performed extensive data cleaning and preprocessing:

- Removed cancelled transactions
- Removed negative quantity records
- Removed zero-priced transactions
- Removed invalid customer IDs
- Converted date columns into proper datetime format
- Created revenue metrics

Revenue Calculation:

```sql
Revenue = Quantity * UnitPrice
```

---

### 2. Revenue Trend Analysis

Analyzed:

- Monthly Revenue
- Quarterly Revenue
- Yearly Revenue
- Month-over-Month Growth
- Quarter-over-Quarter Growth
- Year-over-Year Growth

#### Key Findings

- Revenue showed seasonal fluctuations rather than a continuous decline.
- Significant growth occurred during the latter months of 2011.
- Incomplete data periods were identified and excluded from trend evaluation.

---

### 3. Market Performance Analysis

Evaluated:

- Revenue by Country
- Revenue Share by Country
- Country Growth Trends
- Market Dependency

#### Key Findings

- Revenue was heavily concentrated in the United Kingdom.
- Business performance depended significantly on a single market.
- Geographic diversification opportunities were identified.

---

### 4. Product Performance Analysis

Analyzed:

- Top Revenue-Generating Products
- Product Revenue Contribution
- Product Growth Trends
- Product Revenue Share

#### Key Findings

- Revenue was distributed across multiple products.
- No single product dominated overall sales.
- Certain top-performing products showed declining momentum over time.

---

### 5. Customer Behavior Analysis

Evaluated:

- Unique Customers
- Active Customers
- Repeat Customers
- Customer Purchase Frequency
- Customer Revenue Contribution

#### Key Findings

- Active customer counts increased over time.
- Repeat purchasing behavior remained relatively stable.
- Customer acquisition was not the primary cause of revenue weakness.

---

### 6. High-Value Customer Analysis

Analyzed:

- Top Revenue-Contributing Customers
- Revenue Per Order
- Monthly Spending Patterns

#### Key Findings

- High-value customers continued contributing significantly to revenue.
- Spending patterns improved during later periods.

---

### 7. Order Size Analysis

Evaluated:

- Average Order Value
- Items Per Order
- Order Trends

#### Key Findings

- Average order value fluctuated throughout the analysis period.
- Revenue changes were influenced by multiple factors beyond order size.

---

### 8. Customer Retention & Cohort Analysis

Performed cohort analysis to evaluate customer retention.

Metrics analyzed:

- Cohort Size
- Retention Rate
- Returning Customers
- Customer Lifetime Behavior

#### Key Findings

- Earlier customer cohorts demonstrated stronger retention.
- Newer cohorts retained customers less effectively.
- Customer retention presented a potential area for improvement.

---

## 📈 Power BI Dashboard

An interactive Power BI dashboard was developed to communicate findings and support decision-making.

### Dashboard Components

- Revenue KPI Cards
- Monthly Revenue Trends
- Country Revenue Analysis
- Product Performance Analysis
- Customer Metrics
- Customer Retention Metrics
- Cohort Retention Analysis
- Average Order Value Trends

### Business Questions Answered

#### What Happened?
- Revenue trends and growth patterns

#### Where Did It Happen?
- Country and market-level performance

#### Why Did It Happen?
- Product trends
- Customer behavior
- Customer retention
- Order size patterns

---

## 🔍 Key Insights

- Revenue decline was not driven by customer loss.
- Repeat purchases remained healthy throughout most periods.
- Revenue concentration in a single market increased business risk.
- Product performance varied significantly across categories.
- Customer retention weakened in newer customer cohorts.
- Revenue fluctuations were influenced by a combination of market, product, and customer factors.

---

## 💡 Recommendations

### Market Diversification
Expand presence in international markets to reduce dependency on a single country.

### Customer Retention Strategies
Implement loyalty programs and personalized marketing initiatives to improve retention.

### Product Portfolio Optimization
Monitor declining products and focus on high-performing product categories.

### Customer Segmentation
Develop targeted strategies for high-value customers.

### KPI Monitoring
Track revenue, retention, repeat purchases, and order value using dashboards for continuous performance monitoring.

---

## 📊 Conclusion

This project demonstrates how SQL and Power BI can be used together to perform end-to-end business analysis. Through data cleaning, exploratory analysis, KPI development, cohort analysis, and dashboarding, the project identifies potential causes of revenue leakage and provides actionable insights that can support strategic business decisions.

---

## 👨‍💻 Author

**Dhruv Manchanda**
