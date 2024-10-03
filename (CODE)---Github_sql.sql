CREATE DATABASE Amazon_Data; -- CREATED A DATABASE
USE Amazon_Data; -- SELECT DATABASE

DROP TABLE IF EXISTS Amazon;
CREATE TABLE  Amazon     -- CREATED A NEW TABLE WITH ATTRIBUTES(COLUMNS)
( 
 invoice_id Varchar(50),
 branch Varchar(50),
 city Varchar(50),
 customer_type Varchar(50),
 gender Varchar(10),
 product_line Varchar(50),
 unit_price Decimal(10,2),
 quantity INT,
 VAT  Decimal(6,4),
 total Decimal(10,2),
 date DATE,
 time TIME,
 payment_method Varchar(50),
 cogs Decimal (10,2),
 gross_margin_percentage Decimal(11,9),
 gross_income DECIMAL(10,2),
 rating  Decimal(2,1)
);


SELECT * FROM Amazon; -- CHEACKING DATA IMPORTED CORRECTLY

-- CHECKING FOR NULL VALUES ------------------------------
SELECT SUM(CASE WHEN  invoice_id IS NULL THEN 1 ELSE 0 END) as Null_count_invoice_id ,
SUM(CASE WHEN  branch IS NULL THEN 1 ELSE 0 END) as Null_count_branch ,
SUM(CASE WHEN  city IS NULL THEN 1 ELSE 0 END) as Null_count_city,
SUM(CASE WHEN  customer_type IS NULL THEN 1 ELSE 0 END) as Null_count_customer_type,
SUM(CASE WHEN  gender IS NULL THEN 1 ELSE 0 END) as Null_count_gender,
SUM(CASE WHEN  product_line IS NULL THEN 1 ELSE 0 END) as Null_count_product_line,
SUM(CASE WHEN  unit_price IS NULL THEN 1 ELSE 0 END) as Null_count_unit_price,
SUM(CASE WHEN  quantity IS NULL THEN 1 ELSE 0 END) as Null_count_quantity,
SUM(CASE WHEN  VAT IS NULL THEN 1 ELSE 0 END) as Null_count_VAT,
SUM(CASE WHEN  total IS NULL THEN 1 ELSE 0 END) as Null_count_total,
SUM(CASE WHEN  date IS NULL THEN 1 ELSE 0 END) as Null_count_date,
SUM(CASE WHEN  time IS NULL THEN 1 ELSE 0 END) as Null_count_time,
SUM(CASE WHEN  payment_method IS NULL THEN 1 ELSE 0 END) as Null_count_payment_method,
SUM(CASE WHEN  cogs IS NULL THEN 1 ELSE 0 END) as Null_count_cogs,
SUM(CASE WHEN  gross_margin_percentage IS NULL THEN 1 ELSE 0 END) as Null_count_gross_margin_percentage,
SUM(CASE WHEN  gross_income IS NULL THEN 1 ELSE 0 END) as Null_count_gross_income,
SUM(CASE WHEN  rating IS NULL THEN 1 ELSE 0 END) as Null_count_rating
FROM Amazon ;


-- DATA WRANGLING IS COMPLETED-----------------------------


-- DATA ENGINEERING ---------------

-- ADDING A NEW COLUMN time_of_day
ALTER TABLE Amazon
ADD time_of_day VARCHAR(30);

Select * FROM Amazon; -- CHECKING THE column with time_of_day with NULL

SET SQL_SAFE_UPDATES=0; -- DISABLE SAFE MODE TO UPDATE

Update Amazon
SET time_of_day=( CASE WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
				 WHEN time BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
				ELSE "Evening"
                END
);

SELECT * FROM Amazon;-- CHECKING THE TABLE AS PER REQUIREMENTS

ALTER TABLE Amazon
ADD day_name VARCHAR(30);

SELECT DISTINCT(DAYNAME(date)) FROM Amazon; -- CHECKING DISTINCT DAY OF WEEK


Update Amazon
SET day_name=DAYNAME(date);

SELECT * FROM Amazon;-- CHECKING THE TABLE AS PER REQUIREMENTS


SELECT count(*) as null_check_day_name FROM Amazon
WHERE day_name IS NULL; -- CHECKING IF NOT THE CODE IS PROPERLY IMPLEMENTED


SELECT DISTINCT(MONTHNAME(date)) FROM Amazon; -- CHECKING DISTINCT DAY OF WEEK

ALTER TABLE Amazon                     -- ADDING COLUMNS FRO MONTH NAME
ADD month_name VARCHAR(30);


Update Amazon -- Adding filling the rows with values
SET month_name=MONTHNAME(date);

SELECT * FROM Amazon;                 -- CHECKING ADDED COLUMN

SET SQL_SAFE_UPDATES=1; -- SAFE MODE ON 

SELECT COUNT(month_name) as null_check_month_name  FROM Amazon
WHERE month_name IS NULL;              -- CHECKING FOR ANY NULL VALUE


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Business Questions To Answer:
-- ------------------------------------------------------------------------------------------------------------------------------------------


-- 1) What is the count of distinct cities in the dataset?
SELECT COUNT(DISTINCT(city)) as Count_Distinct_City 
FROM Amazon;


-- 2) For each branch, what is the corresponding city?
SELECT Branch,City as Corresponding_City from Amazon 
GROUP BY Branch,City
ORDER BY Branch,City;


-- 3)  What is the count of distinct product lines in the dataset?
SELECT COUNT(DISTINCT (product_line)) as Distinct_Product_Line_Count 
FROM amazon;

 
-- 4) Which payment method occurs most frequently?
SELECT payment_method,count(payment_method) as count_of_payment 
FROM Amazon
GROUP BY payment_method
ORDER BY count(payment_method) DESC;


-- 5) Which product line has the highest sales?
SELECT Product_line,SUM(cogs) as Sales  
FROM Amazon
GROUP BY Product_line
ORDER BY SUM(cogs) DESC;


-- 6) How much revenue is generated each month?
SELECT Month_Name,SUM(unit_price*quantity) as Revenue
FROM Amazon
GROUP BY Month_Name
ORDER BY Revenue DESC;


-- 7) In which month did the cost of goods sold reach its peak?
SELECT Month_Name,SUM(cogs)  as total_cogs
FROM Amazon
GROUP BY Month_Name
ORDER BY SUM(cogs) DESC;


-- 8) Which product line generated the highest revenue?
SELECT Product_Line,SUM(unit_price*quantity) as Revenue
FROM Amazon
GROUP BY Product_Line
ORDER BY Revenue DESC;


-- 9) In which city was the highest revenue recorded?
SELECT City,sum(unit_price*quantity) as Revenue 
FROM amazon
GROUP BY City 
ORDER BY Revenue DESC;


-- 10) Which product line incurred the highest Value Added Tax?
SELECT Product_line , round(SUM(VAT),2) as Value_Added_Tax
FROM amazon
GROUP BY Product_Line 
ORDER BY Value_Added_Tax DESC;


-- 11) Which product line is most frequently associated with each gender?

WITH gender_1 AS (
    SELECT 
        Product_Line,
        Gender,
        COUNT(Invoice_ID) AS Invoice_count,
        Row_number() over(partition by Gender ORDER BY COUNT(Invoice_ID) DESC) AS Gender_freq
    FROM 
        amazon 
    GROUP BY 
        Gender,
        Product_Line )
    
SELECT * 
FROM gender_1
where Gender_freq=1;

-- 12) Calculate the average rating for each product line.
SELECT Product_line,round(AVG(rating),2) as AVG_Rating
FROM amazon 
GROUP BY Product_Line
ORDER BY AVG(rating) DESC;


-- 13) Count the sales occurrences for each time of day on every weekday.

SELECT day_name,time_of_day,COUNT(cogs) as sales_occurence 
FROM amazon
GROUP BY day_name,time_of_day
ORDER BY day_name,sales_occurence DESC;


-- 14) Identify the customer type contributing the highest revenue.
SELECT customer_type,SUM(unit_price*quantity) AS Revenue
FROM amazon
GROUP BY customer_type
ORDER BY Revenue DESC;


-- 15)  Determine the city with the highest VAT percentage.
SELECT DISTINCT city,round(SUM(VAT) over(Partition by city),2) as VAT_total,round((SUM(VAT) over(Partition by city)/SUM(VAT) over()*100),2) AS VAT_percentage
FROM amazon
ORDER BY VAT_percentage DESC;


-- 16) Identify the customer type with the highest VAT payments.
SELECT customer_type,sum(VAT) AS TOTAL_VAT
FROM amazon
GROUP BY customer_type
ORDER BY TOTAL_VAT DESC;


-- 17) What is the count of distinct customer types in the dataset?
SELECT customer_type,COUNT(DISTINCT(customer_type)) AS CUSTOMER_TYPE
FROM amazon
GROUP BY customer_type;


-- 18) What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT(payment_method)) AS PAYMENT_METHOD  
FROM amazon;


-- 19) Which customer type occurs most frequently?
SELECT customer_type,COUNT(customer_type) AS COUNT_CUSTOMER_TYPE 
FROM amazon
GROUP BY customer_type
ORDER By COUNT_CUSTOMER_TYPE DESC;


-- 20) Identify the customer type with the highest purchase frequency ?
SELECT Customer_type,COUNT(invoice_id) as purcahse_frequency
FROM AMAZON 
GROUP BY customer_type
ORDER BY purcahse_frequency DESC;


-- 21) Determine the predominant gender among customers.
SELECT customer_type,gender,COUNT(invoice_id) as id_count
FROM AMAZON 
GROUP BY gender,customer_type
ORDER BY customer_type,id_count DESC;


-- 22) Examine the distribution of genders within each branch.
SELECT branch, gender, COUNT(gender) AS GENDER_SUM 
FROM amazon 
GROUP BY branch, gender 
ORDER BY BRANCH, GENDER_SUM DESC; 


-- 23) Identify the time of day when customers provide the most ratings.
SELECT time_of_day,round(avg(rating),2) AS avg_rating 
FROM amazon 
GROUP BY time_of_day
ORDER BY avg_rating DESC;


-- 24) Determine the time of day with the highest customer ratings for each branch.
SELECT branch,time_of_day,MAX(rating) AS MAX_Rating 
FROM amazon 
GROUP BY branch,time_of_day
ORDER  BY branch;


-- 25) Identify the day of the week with the highest average ratings.
SELECT day_name,round(avg(rating),2) as AVG_RATING
FROM amazon
GROUP BY day_name
ORDER BY AVG_RATING DESC;


-- 26) Determine the day of the week with the highest average ratings for each branch.
 
WITH BranchRatings AS ( 
    SELECT branch, day_name,  
           ROUND(AVG(rating), 2) AS AVG_RATING 
    FROM amazon 
    GROUP BY branch, day_name 
) 
SELECT b1.branch, b1.day_name, b1.AVG_RATING 
FROM BranchRatings b1 
JOIN ( 
    SELECT branch, MAX(AVG_RATING) AS MAX_AVG_RATING 
    FROM BranchRatings 
    GROUP BY branch 
) b2 ON b1.branch = b2.branch AND b1.AVG_RATING = b2.MAX_AVG_RATING; 

--------------------------------------------------------------------------------------------------

-- Analysis List

-- Product Analysis
-- Conduct analysis on the data to understand the different product lines, 
-- the products lines performing best and the product lines that need to be improved.

SELECT Product_line, round(AVG(quantity),2) as AVG_quantity_product,round(AVG(rating),2) as avg_rating,SUM(unit_price*quantity) as revenue,SUM(cogs) as cost_good_sold_sum
FROM Amazon GROUP BY Product_Line;


-- Sales Analysis
-- This analysis aims to answer the question of the sales trends of product.
--  The result of this can help us measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.

SELECT month_name,SUM(unit_price*quantity) as monthly_revenue, SUM(gross_income) as total_gross_income 
from Amazon 
GROUP BY month_name 
ORDER BY month_name desc ; 


-- Customer Analysis
-- This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.

SELECT gender,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  gender ;
SELECT customer_type,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  customer_type ;
SELECT customer_type,gender,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  customer_type,gender ;
