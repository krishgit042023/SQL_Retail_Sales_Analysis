# SQL_Retail_Sales_Analysis

# 🛍️ Retail Sales Data Analysis using SQL

This project involves a comprehensive analysis of a retail sales dataset using PostgreSQL (via pgAdmin 4). The goal is to extract business insights from transaction data, customer behavior, and product performance across categories and time periods.

---

## 📂 Dataset Overview

The dataset consists of a `retail_sales` table with the following columns:

- `transaction_id`: Unique ID for each sale
- `sale_date`: Date of the transaction
- `sale_time`: Time of the transaction
- `customer_id`: Unique ID for each customer
- `gender`: Gender of the customer (Male/Female)
- `age`: Age of the customer
- `category`: Product category (e.g., Clothing, Beauty, etc.)
- `quantity`: Number of units sold
- `price_per_unit`: Price per item
- `cogs`: Cost of goods sold
- `total_sale`: Total sale amount (quantity × price)
- `profit`: (Added column) Profit = total_sale - cogs

---

## 🔧 Tools Used

- PostgreSQL
- pgAdmin 4
- SQL (Structured Query Language)

---

## 📊 Analysis Performed

### 1. **Data Cleaning**
- Checked and deleted rows with `NULL` values.
- Verified row counts before and after cleaning.

### 2. **Sales Summary**
- Total number of transactions.
- High-value transactions (`total_sale > 1000`).
- Total and average monthly sales.
- Best-selling month per year.

### 3. **Customer Analysis**
- Total and unique customers.
- Top 5 customers based on highest total sales.
- Average age of customers by category (e.g., Beauty).

### 4. **Category & Gender Insights**
- Unique customers and total orders per category.
- Total and percentage profit by gender and category.
- Number of transactions by gender per category.

### 5. **Time-based Insights**
- Created shifts: Morning (<12), Afternoon (12–17), Evening (>17).
- Counted total orders in each shift.

---

## 🧮 Key Queries Used

- Profit percentage by gender/category
- Total sales and transactions by gender
- Top customers by sales
- Monthly average sales
- Category-wise and date-specific filters (e.g., Clothing in Nov-2022)

---

## ✅ Key Insights

- Clothing had the highest volume during Nov-2022.
- Males and females showed distinct profit and sales contributions.
- Most transactions occurred during afternoon shifts.
- Certain customers contributed significantly to overall sales.

---



---

## 📌 How to Use

1. Run the SQL scripts in pgAdmin 4 using your PostgreSQL connection.
2. Load your `retail_sales` data.
3. Execute the queries provided in `/sql-scripts/` for insights.
4. Modify or extend queries based on your own dataset needs.

---

## 💡 Future Improvements

- Add visualizations using Python (Matplotlib/Seaborn) or Power BI.
- Automate reporting using scheduled SQL jobs.
- Integrate predictive analytics for sales forecasting.

---

## 📬 Contact

Feel free to reach out for any queries or collaboration opportunities.
