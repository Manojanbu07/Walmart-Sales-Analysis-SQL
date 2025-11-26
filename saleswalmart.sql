USE salesdatawalmart
SELECT * FROM salesdatawalmart.sales;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------FEATURE ENGINEERING-----------SET IIME_DATE
SELECT time,(CASE
 WHEN 'time' BETWEEN "00:00:00" AND"12:00:00" THEN "Morning"
WHEN 'time' BETWEEN "12:01:00" AND"16:00:00" THEN "Afternoon"
ELSE "Evening"
END )  AS time_of_date
 FROM sales;
 ---------------------------------
 ALTER TABLE sales ADD COLUMN time_of_date VARCHAR(20)
 -------------------------------------
 UPDATE sales
 SET time_of_date=(CASE
 WHEN 'time' BETWEEN "00:00:00" AND"12:00:00" THEN "Morning"
WHEN 'time' BETWEEN "12:01:00" AND"16:00:00" THEN "Afternoon"
ELSE "Evening"
END
);
---------------------------------------------------
SELECT * FROM sales;
------------FEATURE ENGINEERING 2 DAY_NAME-------
SELECT date,DAYNAME(date)  AS day_name
FROM sales;
ALTER TABLE sales ADD column day_name VARCHAR(10);

UPDATE sales
SET day_name=dayname(date);
SELECT * FROM sales;


------------------FEATURE ENGINEERING 3--- MONTH_COLUMN
SELECT date,MONTHNAME(date)  FROM sales;
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name=monthname(date);
SELECT * FROM sales;













-----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
-----------------------------------GENERIC--------------------------------------------------------
1.how many unique cities does the data have?
SELECT DISTINCT city FROM sales;
----------------------------------
2.in which unique branch cities have?
SELECT DISTINCT branch FROM sales;
---
SELECT distinct city,branch FROM sales;

4.How many unique product lines does the data have?
SELECT DISTINCT product_line FROM sales;
-----------------------------------------
5.What is the most common payment method?
SELECT DISTINCT payment_method, COUNT(payment_method) FROM sales
GROUP BY payment_method
ORDER BY payment_method DESC
-----------------------------------------
6.What is the most selling product line?
SELECT DISTINCT product_line, COUNT(product_line) FROM sales
GROUP BY product_line
ORDER BY  COUNT(product_line) DESC
------------------------------------------------
7.What is the total revenue by month?
SELECT month_name,
SUM(total) AS total_revenue FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;
---------------------------------------
8. What month had the largest COGS?
SELECT month_name,
SUM(cogs) AS total_cogs FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;
--------------------------------------------------
9.What product line had the largest revenue?
SELECT product_line,SUM(total) AS total_revenue FROM sales
GROUP by product_line
ORDER by total_revenue DESC
-----------------------------------------------
10.What product line had the largest revenue?
SELECT city,SUM(total) AS total_revenue FROM sales
GROUP by city
ORDER by total_revenue DESC
----------------------------------------------------------
11.What product line had the largest VAT?
SELECT product_line,AVG(VAT) AS total_vat FROM sales
GROUP by product_line
ORDER by total_vat DESC;
--------------------------------------------------------------------------------------------------------------------------------
12.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales?
SELECT product_line,SUM(total) AS total_sales
 FROM sales
 GROUP BY product_line;
SELECT avg(total_sales)
 FROM (SELECT SUM(totaL) AS total_sales
 FROM sales
 GROUP BY product_line
 ) as sub;
 SELECT product_line , SUM(total) AS total_sales,
 CASE WHEN SUM(total)>(SELECT AVG(total_sales)
 FROM (SELECT SUM(total)AS total_sales
 FROM sales
 GROUP BY product_line
 ) AS sub
 ) THEN 'good'
 ELSE 'Bad'
 END AS performance 
 FROM sales
 GROUP BY product_line;
 -------------------------------------
 13.What is the most common product line by gender?
 SELECT gender,product_line,COUNT(gender) AS total_count FROM sales
 GROUP By gender,product_line
 ORDER BY gender DESC;
 ------------------------------------------------------
 14.What is the average rating of each Productline?
 SELECT ROUND(Avg(rating),2) as avg_rating,product_line FROM sales
 GROUP BY product_line
 ORDER BY avg_rating DESC;
----------------------------------------------------------------------
------------------------Sales Analysis-------------------
1.Number of sales made in each time of the day per weekday
SELECT time_of_date,COUNT(*) AS total_sales FROM sales
WHERE day_name="Monday"
GROUP BY time_of_date
ORDER BY total_sales DESC;
2.Which of the customer types bring the most revenue
SELECT customer_type , SUM(total)FROM sales
GROUP BY customer_type
ORDER BY  SUM(total) DESC;
3.Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT city,AVG(VAT) FROM sales
GROUP BY city
ORDER BY SUM(VAT) DESC
4.Which customer pays more in VAT?
SELECT customer_type,AVG(VAT) AS AVG FROM sales
GROUP BY customer_type
ORDER BY AVG DESC
--------------------------------------------------------------------------------------------------------
------------------------------CUSTOMER DATA ANALYSIS----------
1.How many unique customer types does the data have?
SELECT DISTINCT customer_type FROM sales;
2.How many unique payment methods does the data have?
SELECT DISTINCT payment_method FROM sales;
3.What is the most common customer type?
SELECT customer_type , COUNT(*) AS cstm_cnt FROM sales
GROUP BY customer_type 
ORDER BY cstm_cnt DESC
4.What is the gender of most of the customers?
SELECT gender , COUNT(*) AS cstm_cnt FROM sales
GROUP BY gender 
ORDER BY cstm_cnt DESC
5.What is the gender distribution per branch?
SELECT gender,COUNT(*) AS gender_count FROM sales
WHERE branch="C" AND "A"
GROUP BY gender
ORDER BY gender_count ASC;
