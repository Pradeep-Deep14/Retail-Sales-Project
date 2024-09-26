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

SELECT * FROM RETAIL_SALES

-- DATA CLEANING

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
-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
WHERE SALE_DATE='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category='Clothing'
AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
AND QUANTITY >=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select  CATEGORY,
 		SUM(TOTAL_SALE)  AS TOTAL_SALES,
		COUNT(*)
FROM RETAIL_SALES
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(AGE),2) AS AVERAGE_AGE
FROM RETAIL_SALES
WHERE CATEGORY='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT GENDER,
       CATEGORY,
       COUNT(*)
FROM RETAIL_SALES
GROUP BY 1,2
ORDER BY 2

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT CUSTOMER_ID,
	   SUM(TOTAL_SALE) AS SUM_OF_SALE
FROM 
RETAIL_SALES
GROUP BY 1
ORDER BY  1,SUM(TOTAL_SALE) DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 	CATEGORY,
		COUNT(DISTINCT CUSTOMER_ID) AS COUNT_OF_UNIQUE_CUSTOMERS
FROM RETAIL_SALES
GROUP BY 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

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
