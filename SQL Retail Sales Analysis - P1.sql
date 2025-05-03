--SQL Retail Sales Analysis - P1
create database sql_projetc_p2;

-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY,
			    sale_date	DATE,
			    sale_time	TIME,
			    customer_id	 INT,
			    gender	  VARCHAR,    
			    age	      INT,
			    category	VARCHAR(15),
				quantiy	 INT,
				price_per_unit	FLOAT,
				cogs	    FLOAT,
				total_sale  FLOAT
			)

select * from retail_sales
limit 10

SELECT COUNT(*) FROM retail_sales;

--checking for null values
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(transactions_id) AS null_transactions_id,
    COUNT(*) - COUNT(sale_date) AS null_sale_date,
    COUNT(*) - COUNT(sale_time) AS null_sale_time,
    COUNT(*) - COUNT(customer_id) AS null_customer_id,
    COUNT(*) - COUNT(gender) AS null_gender,
    COUNT(*) - COUNT(age) AS null_age,
    COUNT(*) - COUNT(category) AS null_category,
    COUNT(*) - COUNT(quantiy) AS null_quantity,
    COUNT(*) - COUNT(price_per_unit) AS null_price_per_unit,
    COUNT(*) - COUNT(cogs) AS null_cogs,
    COUNT(*) - COUNT(total_sale) AS null_total_sale
FROM retail_sales;


--DATA CLEANING

--deteleting the null values
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;


SELECT COUNT(*) FROM retail_sales;
select * from retail_sales

--DATA EXPLORATION (EDA)

 --How many sales we have
SELECT COUNT(*) AS total_sales FROM retail_sales;

--How many unique customer we have
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

--Adding a new column (Profit= total_sales - cogs)
ALTER TABLE retail_sales
ADD COLUMN profit NUMERIC(12,2);
UPDATE retail_sales
SET profit = total_sale - cogs;


-- How many unique category we have
SELECT COUNT(DISTINCT category) AS unique_category_count
FROM retail_sales;

--List of category
SELECT DISTINCT category
FROM retail_sales;


--Data Analysis and Business Key Problems and Answers

--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >=4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--3.Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
  category, 
  COUNT(*) AS total_orders,
  SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
 
--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT AVG(age) AS average_age_beauty_customers
FROM retail_sales
WHERE category = 'Beauty';

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    gender, 
    category, 
    COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY gender, category;


--Depending on the category percentage of male and female purchased

SELECT 
    category,
    gender,
    COUNT(*) AS total_transactions,
    ROUND(
        (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY category), 
        2
    ) AS gender_percentage
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender;

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

--average monthly sales per year:
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale)::numeric, 2) AS avg_monthly_sale
FROM retail_sales
GROUP BY year, month
ORDER BY year, month;

--Best-selling month (with highest average sale) per year:
WITH monthly_avg AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY year, month
)
SELECT *
FROM monthly_avg ma
WHERE avg_sale = (
    SELECT MAX(avg_sale)
    FROM monthly_avg
    WHERE year = ma.year
)
ORDER BY year;

--8.top 5 customers based on the highest total sales
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

--9.Finding the number of unique customers who purchased items from each category.:
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;

--10.create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift
ORDER BY total_orders DESC;


select * from retail_sales


--Percentage of profit done by male and female
SELECT 
    gender,
    ROUND(SUM(profit) * 100.0 / SUM(SUM(profit)) OVER (), 2) AS profit_percentage
FROM retail_sales
GROUP BY gender;

--profit percentage from different category
SELECT 
    category,
    ROUND(SUM(profit) * 100.0 / SUM(SUM(profit)) OVER (), 2) AS profit_percentage
FROM retail_sales
GROUP BY category
ORDER BY profit_percentage DESC;

--total sales done by male and female
SELECT 
    gender,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY gender
ORDER BY total_sales DESC;





