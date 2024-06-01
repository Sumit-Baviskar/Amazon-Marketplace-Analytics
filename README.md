# Amazon-sales (SQL Project )

# Purposes Of This Capstone Project


The major aim of this project is to gain insight into the sales data of Amazon to understand the different factors that affect sales of the different branches. Gather the information to give solution the client question and requirement that improve sales so they can take data-driven decision.


# About Data

This dataset contains sales transactions from three different branches of Amazon, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:



            

# Business Questions To Answer

1)What is the count of distinct cities in the dataset?

2)For each branch, what is the corresponding city?

3)What is the count of distinct product lines in the dataset?

4)Which payment method occurs most frequently?

5)Which product line has the highest sales?

6)How much revenue is generated each month?

7)In which month did the cost of goods sold reach its peak?

8)Which product line generated the highest revenue?

9)In which city was the highest revenue recorded?

10)Which product line incurred the highest Value Added Tax?

11)For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

12)Identify the branch that exceeded the average number of products sold.

13)Which product line is most frequently associated with each gender?

14)Calculate the average rating for each product line.

15)Count the sales occurrences for each time of day on every weekday.

16)Identify the customer type contributing the highest revenue.

17)Determine the city with the highest VAT percentage.

18)Identify the customer type with the highest VAT payments.

19)What is the count of distinct customer types in the dataset?

20)What is the count of distinct payment methods in the dataset?

21)Which customer type occurs most frequently?

22)Identify the customer type with the highest purchase frequency.

23)Determine the predominant gender among customers.

24)Examine the distribution of genders within each branch.

25)Identify the time of day when customers provide the most ratings.

26) Determine the time of day with the highest customer ratings for each branch.

27)Identify the day of the week with the highest average ratings.

28)Determine the day of the week with the highest average ratings for each branch.

# Approach Used--

**1. Data Wrangling:** This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace missing or NULL values.

**1.1 Build a database**

- created a base named” Amazon_data "

        CREATE DATABASE Amazon_Data; -- CREATED A DATABASE
        USE Amazon_Data; -- SELECT DATABASE
        

  
**1.2 Create a table and insert the data**

- create a new table name “Amazon”.

  
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

**1.3 Select columns with null values in them. There are no null values in our database as. in creating the tables, we set NOT NULL for each field, hence null values are filtered out.**

-- checked for not null .there are no null values in our dataset.


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

          DESCRIBE Amazon;
          
**2. Feature Engineering:** This will help us generate some new columns from existing ones.

**2.1 ) Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.**


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


-- creating new column and updating data accordingly with Morning , Afternoon, Evening category in the time_of_day columns by using case statement . Category of time_of_day with Morning(190 rows),Afternoon(525 rows),Evening(280 rows)


**2.2 ) Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.**


          Update Amazon
          SET day_name=DAYNAME(date);

          SELECT * FROM Amazon;-- CHECKING THE TABLE AS PER REQUIREMENTS
          SELECT count(*) as null_check_day_name FROM Amazon
          WHERE day_name IS NULL; -- CHECKING IF NOT THE CODE IS PROPERLY IMPLEMENTED


          SELECT DISTINCT(MONTHNAME(date)) FROM Amazon; -- CHECKING DISTINCT DAY OF WEEK

-- Added a new column as ”DayName” at the last of the table using Dayname with Date function the field is filled. There was 5 distinct values Monday, Tuesday, Wednesday, Thursday, and Friday.

**2.3 ) Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.**
          
          
          ALTER TABLE Amazon                     -- ADDING COLUMNS FRO MONTH NAME
          ADD month_name VARCHAR(30);


          Update Amazon -- Adding filling the rows with values
          SET month_name=MONTHNAME(date);

          SELECT * FROM Amazon;                 -- CHECKING ADDED COLUMN

          SET SQL_SAFE_UPDATES=1; -- SAFE MODE ON 

          SELECT COUNT(month_name) as null_check_month_name  FROM Amazon
          WHERE month_name IS NULL;              -- CHECKING FOR ANY NULL VALUE


-- using the MONTHNAME is used with date to get month from date and get the column filled with all values. There are January, February and March.


# **Business Questions To Answer:**


**1) What is the count of distinct cities in the dataset?**


        SELECT COUNT(DISTINCT(city)) as Count_Distinct_City 
        FROM Amazon;
   
-- Count of distinct city is 3 ( Yangon, Naypyitaw , Mandalay)

**2) For each branch, what is the corresponding city?**
 
         SELECT Branch,City as Corresponding_City from Amazon 
         GROUP BY Branch,City
         ORDER BY Branch,City;


-- Each branch has only one city to each branch . Branch A- Yangon, Branch C- Naypyitaw , Branch B-Mandalay respectively

**3) What is the count of distinct product lines in the dataset?**

       SELECT COUNT(DISTINCT (product_line)) as Distinct_Product_Line_Count 
       FROM amazon;


-- There are 6 distinct product line count (Health and Beauty, Electronics accessories, Sport and travel, Home and lifestyle, Food and Beverages, Fashion accessories)


**4) Which payment method occurs most frequently?**


       SELECT payment_method,count(payment_method) as count_of_payment 
       FROM Amazon
       GROUP BY payment_method
       ORDER BY count(payment_method) DESC;

-- Most payment method is Cash followed by E-wallet , Credit cash.

**5) Which product line has the highest sales?**
       
       
       SELECT Product_line,SUM(cogs) as Sales  
       FROM Amazon
       GROUP BY Product_line
       ORDER BY SUM(cogs) DESC;
       
-- Highest sales is done by Food and Beverages followed by Fashion accessories, Sport and travel, Home and lifestyle, Electronics accessories and Health and Beauty has lowest sales.

**6) How much revenue is generated each month?**
        
        
        SELECT Month_Name,SUM(unit_price*quantity) as Revenue
        FROM Amazon
        GROUP BY Month_Name
        ORDER BY Revenue DESC;

-- Highest revenue is earned in January Followed by March and February.

**7) In which month did the cost of goods sold reach its peak?**
    
        
        SELECT Month_Name,SUM(cogs)  as total_cogs
        FROM Amazon
        GROUP BY Month_Name
        ORDER BY SUM(cogs) DESC;

-- January is the highest revenue month followed by March and February. This analysis can be get by summing cogs(Cost Of Goods sold ) by grouping the month. There are only 3 months January, February and March.
 
**8) Which product line generated the highest revenue?**
        
        
        SELECT Product_Line,SUM(unit_price*quantity) as Revenue
        FROM Amazon
        GROUP BY Product_Line
        ORDER BY Revenue DESC;

-- We have calculate summed the unit price and quantity get revenue and order by Revenue . As Food and beverages has generate the highest revenue followed by fashion accessories ,Sport & travel ,home & life style , Electronics & accessories and Health & beauty.

**9) In which city was the highest revenue recorded?**
        
        
        SELECT City,sum(unit_price*quantity) as Revenue 
        FROM amazon
        GROUP BY City 
        ORDER BY Revenue DESC;

-- As mentioned above, we calculate revenue by adding gross income and cost of sold goods has arranged in descending to get city with highest revenue which is Naypyitaw Followed by Yangon ,Mandalay.

**10) Which product line incurred the highest Value Added Tax?**
        
        
        SELECT Product_line , round(SUM(VAT),2) as Value_Added_Tax
        FROM amazon
        GROUP BY Product_Line 
        ORDER BY Value_Added_Tax DESC;

-- As the vat is given which is grouped by product line get us insight that the Food & beverages Followed by accessories Sport & travel, Home & travel Electronics accessories, and Health & beauty.

**11) Which product line is most frequently associated with each gender?**


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

-- As there is different preferences to product line for female which is Fashion accessories , Food & beverages , Sport & travel, Electronics accessories, Home & lifestyle and Health & beauty,
Male had preferences to Health & beauty followed by Electronics accessories, Food & beverages, Fashion accessories , Home & lifestyle and Sport & travel.

**12) Calculate the average rating for each product line?**
        
        
        SELECT Product_line,round(AVG(rating),2) as AVG_Rating
        FROM amazon 
        GROUP BY Product_Line
        ORDER BY AVG(rating) DESC;

-- The highest average rating for product line is Food & beverages followed by Fashion accessories, Health & beauty, Electronics accessories , Sport & travel and Home & lifestyle.

**13) Count the sales occurrences for each time of day on every weekday?**
        
        
        SELECT day_name,time_of_day,COUNT(cogs) as sales_occurence 
        FROM amazon
        GROUP BY day_name,time_of_day
        ORDER BY day_name,sales_occurence DESC;

-- The highest sales occurrences at Saturday(Evening) followed by Tuesday(Evening),Wednesday(Afternoon).

 **14) Identify the customer type contributing the highest revenue?**


        SELECT customer_type,SUM(unit_price*quantity) AS Revenue
        FROM amazon
        GROUP BY customer_type
        ORDER BY Revenue DESC;
        
-- There are only two customer type as member and normal but as per revenue member customer type generate more revenue than normal customer type around 4% more than normal member type.

**15) Determine the city with the highest VAT percentage?**


        SELECT DISTINCT city,round(SUM(VAT) over(Partition by city),2) as VAT_total,round((SUM(VAT) over(Partition by city)/SUM(VAT) over()*100),2) AS 
        VAT_percentage
        FROM amazon
        ORDER BY VAT_percentage DESC;


-- As the cities is arranged in the highest VAT are Naypyitaw after that Yangon and Mandalay. Yangon and Mandalay had the similar percentage but the value of Yangon is higher then Mandalay.

**16) Identify the customer type with the highest VAT payments?**


      SELECT customer_type,sum(VAT) AS TOTAL_VAT
      FROM amazon
      GROUP BY customer_type
      ORDER BY TOTAL_VAT DESC;

-- There is a small difference between only 2 customer type which is normal and member type . Member has sightly higher value which is around 300 more than normal customer type VAT value.

**17) What is the count of distinct customer types in the dataset?**

 
       SELECT customer_type,COUNT(DISTINCT(customer_type)) AS CUSTOMER_TYPE
       FROM amazon
       GROUP BY customer_type;

-- There are only 2 customer type Member and Normal customer type.

**18) What is the count of distinct payment methods in the dataset?**

  
      SELECT COUNT(DISTINCT(payment_method)) AS PAYMENT_METHOD  
      FROM amazon;
      
-- There is only 3 payment method which is E-wallet, cash and credit card


**19) Which customer type occurs most frequently?**


       SELECT customer_type,COUNT(customer_type) AS COUNT_CUSTOMER_TYPE 
       FROM amazon
       GROUP BY customer_type
       ORDER By COUNT_CUSTOMER_TYPE DESC;

-- There are normal and member customer type but there are 3 members customer type than normal customer type.

**20) Identify the customer type with the highest purchase frequency?**


      SELECT Customer_type,COUNT(invoice_id) as purcahse_frequency
      FROM AMAZON 
      GROUP BY customer_type
      ORDER BY purcahse_frequency DESC;

-- There are normal and member customer type but there are 3 members customer type than normal customer type.

**21) Determine the predominant gender among customers?**


      SELECT customer_type,gender,COUNT(invoice_id) as id_count
      FROM AMAZON 
      GROUP BY gender,customer_type
      ORDER BY customer_type,id_count DESC;
      
-- In member customer type, there are female are predominant than male and in normal customer type, there are male are predominant than female.

**22) Examine the distribution of genders within each branch?**


       SELECT BRANCH,GENDER,COUNT(GENDER) AS GENDER_SUM
       FROM amazon
       GROUP BY BRANCH,GENDER
       ORDER BY BRANCH, GENDER_SUM DESC;
       
-- Gender distribution among branch A has male has 179 members and Female 160 members, branch B has male has 169 members and Female 160 members, and So branch A has Female has 177 members and Female 150 members

**23) Identify the time of day when customers provide the most ratings?**


       SELECT time_of_day,round(avg(rating),2) AS avg_rating 
       FROM amazon 
       GROUP BY time_of_day
       ORDER BY avg_rating DESC;
       
-- As per data, Afternoon has highest average rating has 7.02 rating followed by Morning and Evening

**24) Determine the time of day with the highest customer ratings for each branch?**
    
    
         SELECT branch,time_of_day,MAX(rating) AS MAX_Rating 
         FROM amazon 
         GROUP BY branch,time_of_day
         ORDER  BY branch;
         
-- For every branch there is a time of day in which the highest rating is given 9.9 rating at each time of day for each branch has given 9.9 rating ones in every time of day.

**25) Identify the day of the week with the highest average ratings?**


        SELECT day_name,round(avg(rating),2) as AVG_RATING
        FROM amazon
        GROUP BY day_name
        ORDER BY AVG_RATING DESC;

        
-- Monday has highest average rating 7.13 rating followed by Friday(7.06), Tuesday(7.00) , Sunday(6.99) , Saturday(6.90) ,Thursday(6.89) and Wednesday(6.76).

**26) Determine the day of the week with the highest average ratings for each branch?**


         SELECT branch,day_name,round(avg(rating),2) as MAX_AVG_RATING
         FROM amazon
         GROUP BY branch,day_name
         ORDER BY branch,MAX_AVG_RATING DESC;

-- For branch A , Friday(7.31) as highest average rating followed byMonday(7.10) ,Sunday, Tuesday, Thursday, Wednesday and Saturday.
For Branch B, Monday (7.27) as highest average rating followed by Tuesday, Sunday, Thursday, Saturday, Friday, Wednesday .
For Branch C, Saturday(7.23) as highest average rating followed by Friday, Wednesday, Monday , Sunday, Tuesday, and Thursday .




# Analysis List


**--> Product Analysis**Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.


**CODE**


    SELECT Product_line, round(AVG(quantity),2) as AVG_quantity_product,round(AVG(rating),2) as avg_rating,SUM(unit_price*quantity) as revenue,SUM(cogs) as cost_good_sold_sum
    FROM Amazon GROUP BY Product_Line;
   
**Product Line – there are 6 distinct product line-**

Health and Beauty

Electronics accessories

Sport and travel

Home and lifestyle

Food and Beverages 

Fashion accessories

**He product line should be test on average quantity produced ,average rating, revenue and cogs(cost of goods sold)**

Average quantity produced by each product line – so there is highest product line is home and lifestyle, Electronics accessories, Health & beauty, Sport and travel , Food and beverages and Fashion accessories

By rating if we rank product line home and lifestyle , Sports and travel, Electronics and accessories, health and beauty ,Fashion and accessories and Food & beverages .
According to revenue, Food and beverages followed by Fashion accessories ,sports and travel , Food & beverages . ,home & lifestyle ,Electronics accessories and Health & beauty.

If we use criteria of good sold by each product line Food and beverages , Fashion accessories, Sports and travel, home and travel , home & lifestyle, Electronics & accessories and Health & beauty.

As per the above criteria we can see, the product line like Electronics and accessories, home and lifestyle, Food and beverages are good performers product line . By the health &beauty and home& lifestyle are low performing product line and should used some strategy to improve the revenue , rating and unit sold .



**--> Sales Analysis**


    SELECT month_name,SUM(unit_price*quantity) as monthly_revenue, SUM(gross_income) as total_gross_income 
    from Amazon 
    GROUP BY month_name 
    ORDER BY month_name desc ; 
    
This analysis aims to answer the question of the sales trends of product. The result of this can help us measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.

Sales analysis can be done by revenue and gross income generated by each month . So as per data we can analyze and get insight that monthly revenue generated is highest at January followed March and February and if we arranged by criteria of total gross income in January followed March and February
So Sales in February is reduce to certain extend so with sales strategy to improve sales in February and March.


**--> Customer Analysis**


    SELECT gender,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  gender ;
    SELECT customer_type,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  customer_type ;
    SELECT customer_type,gender,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  customer_type,gender ;

This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.

Customer Analysis can be done by order behavior by average order value, count of order by each customer . There are member customer type has more average order values than normal customer type.
Femal has more average order value than men which is around 150 more than men in each order placed by men. As more deep analysis Member female has highest average order value followed by normal female customer type, Member male and lowest male normal customer type .
We have to make improvement in male category sales and specially in normal customer type.
