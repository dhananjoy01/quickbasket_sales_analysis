------------Quick_Basket_Retail_Sales_Analysis

---Creating database

CREATE DATABASE Retail_sales_analysis;


--Making Table
CREATE TABLE retail_sales(
      transactions_id INT PRIMARY KEY,
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
	  );
---Show table data
SELECT * FROM retail_sales
LIMIT 100


----Total data
SELECT 
    COUNT(*)
FROM retail_sales
------------------
SELECT * FROM retail_sales
WHERE sale_date IS NUll

SELECT * FROM retail_sales
WHERE
    sales_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-----------------Delete the null data
DELETE * retail_sales
WHERE
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

------------------Answerng question
--1.How nany sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales
---2. How many customar we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales
---3. How many catagory we have?
SELECT DISTINCT category FROM retail_sales

-------Data Analysis & Key Problems with Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-----------Answer to the question no 1-----------------------
SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05';

-----------Answer to the question no 2------------------------
SELECT *
FROM retail_sales
WHERE
   category='Clothing'
   AND
   TO_CHAR(sale_date,'YYYY-MM')='2022-11'
   AND
   quantity>=4;

-----------Answer to the question no 3------------------------
SELECT
     category,
	 SUM(total_sale)AS net_sale,
	 COUNT(*)AS total_orders
FROM retail_sales
GROUP BY 1;

-----------Answer to the question no 4------------------------
SELECT ROUND(AVG(age),0)
FROM retail_sales
WHERE category='Beauty';

-----------Answer to the question no 5------------------------
SELECT *
FROM retail_sales
WHERE total_sale>1000;

-----------Answer to the question no 6------------------------
SELECT
    category,
	gender,
	COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY
    category,
	gender
ORDER BY
    category;

-----------Answer to the question no 7------------------------
SELECT 
       	year,
       	month,
	avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;

-----------Answer to the question no 8------------------------

SELECT customer_id,
	SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-----------Answer to the question no 9------------------------
SELECT 
	DISTINCT category,
	COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY 1;


-----------Answer to the question no 10------------------------

SELECT
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS Shift,
	COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END;

------------------End of project------------------------------------









