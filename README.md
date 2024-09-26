# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Retail DB`
**Table Name**: `Retail Sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail DB`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE TABLE retail_sales
(
transaction_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
) ;
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
  
### DATA CLEANING
```sql
SELECT * FROM RETAIL_SALES

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

DELETE FROM retail_sales
WHERE
transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

-- How many category do we have ?
	
SELECT DISTINCT category FROM retail_sales
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
SELECT * FROM retail_sales
WHERE SALE_DATE='2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM retail_sales
WHERE category='Clothing'
AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
AND QUANTITY >=4

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

```sql
select  CATEGORY,
 		SUM(TOTAL_SALE)  AS TOTAL_SALES,
		COUNT(*)
FROM RETAIL_SALES
GROUP BY 1
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
SELECT ROUND(AVG(AGE),2) AS AVERAGE_AGE
FROM RETAIL_SALES
WHERE CATEGORY='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT * FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
SELECT GENDER,
       CATEGORY,
       COUNT(*)
FROM RETAIL_SALES
GROUP BY 1,2
ORDER BY 2
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
SELECT * FROM
(
SELECT 
	EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
	EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	AVG(TOTAL_SALE) AS AVERAGE_SALE,
	RANK()OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE))AS RNK
FROM RETAIL_SALES
GROUP BY 1,2
ORDER BY 1,3 DESC
) AS T1
WHERE RNK=1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**

```sql
SELECT CUSTOMER_ID,
	   SUM(TOTAL_SALE) AS SUM_OF_SALE
FROM 
RETAIL_SALES
GROUP BY 1
ORDER BY  1,SUM(TOTAL_SALE) DESC
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
SELECT 	CATEGORY,
		COUNT(DISTINCT CUSTOMER_ID) AS COUNT_OF_UNIQUE_CUSTOMERS
FROM RETAIL_SALES
GROUP BY 1
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql

WITH HOURLY_SALE
AS
(
SELECT *,
		EXTRACT(HOUR FROM SALE_TIME) AS HOUR_OF_THE_DAY,   
       	CASE
           WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'Afternoon'
		   ELSE 'Evening'
       END AS SHIFT
FROM RETAIL_SALES
)
SELECT SHIFT,
       COUNT(*)AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts and Engineers, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

