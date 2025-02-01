# :chart_with_upwards_trend:Amazon Marketplace Analytics(SQL Project):chart_with_upwards_trend:


# :green_book: **Introduction :**

 The primary objective of this project is to analyze sales data from three branches of Amazon, located in Mandalay, Yangon, and Naypyitaw, to uncover key insights that can drive data-informed decisions for optimizing sales performance. By understanding the various factors influencing sales across these branches, the goal is to assist stakeholders in identifying trends, anomalies, and potential areas for improvement.

 
This dataset comprises **1,000 rows and 17 columns**, capturing essential details about sales transactions, such as branch location, product categories, customer demographics, sales amounts, payment methods, and other relevant metrics. By thoroughly analyzing this data, the project aims to answer critical business questions, improve sales strategies, and optimize branch-specific performance.


Through exploratory data analysis, statistical modeling, and data visualization, we will identify patterns, correlations, and trends that impact sales. The insights drawn from this analysis will help Amazon’s regional managers and decision-makers implement more effective strategies to boost revenue, enhance customer satisfaction, and streamline operations across all three branches.

# :green_book: **Purpose :**


The purpose of this project is to provide Amazon with actionable insights into the sales performance of its three branches—Mandalay, Yangon, and Naypyitaw. By analyzing the sales data, the aim is to identify key factors that affect sales outcomes, such as product demand, customer preferences, seasonal trends, and payment methods. The insights gained from this analysis will help Amazon's management team make informed, data-driven decisions to:

- **1) Optimize sales strategies for each branch.**
  
- **2) Enhance customer satisfaction by understanding buying behavior.**

- **3) Identify high-performing and underperforming products.**
     
- **4) Improve operational efficiency through better resource allocation.**
     
Ultimately, this project aims to empower Amazon's decision-makers to implement targeted strategies that will drive sales growth, increase revenue, and ensure the long-term success of the business.


# :green_book: **About Data :**

This dataset contains sales transactions from three different branches of Amazon, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

- **invoice_id :Invoice of the sales made**
  
- **branch :Branch at which sales were made**

- **city :The location of the branch**

- **customer_type :The type of the customer**

- **gender :Gender of the customer making purchase**

- **product_line :Product line of the product sold**

- **unit_price :The price of each product**

- **quantity :The amount of the product sold**

- **VAT :The amount of tax on the purchase**

- **total :The total cost of the purchase**
  
- **date :The date on which the purchase was made**

- **time :The time at which the purchase was made**

- **payment_method :The total amount paid**

- **cogs :Cost Of Goods sold**

- **gross_margin_percentage :Gross margin percentage**

- **gross_income :Gross Income**

- **rating :Rating**


            

# :green_book: **Business Questions To Answer :**

**1) What is the count of distinct cities in the dataset?**

**2) For each branch, what is the corresponding city?**

**3) What is the count of distinct product lines in the dataset?**

**4) Which payment method occurs most frequently?**

**5) Which product line has the highest sales?**

**6) How much revenue is generated each month?**

**7) In which month did the cost of goods sold reach its peak?**

**8) Which product line generated the highest revenue?**

**9) In which city was the highest revenue recorded?**

**10) Which product line incurred the highest Value Added Tax?**

**11) Which product line is most frequently associated with each gender?**

**12) Calculate the average rating for each product line.**

**13) Count the sales occurrences for each time of day on every weekday.**

**14) Identify the customer type contributing the highest revenue.**

**15) Determine the city with the highest VAT percentage.**

**16) Identify the customer type with the highest VAT payments.**

**17) What is the count of distinct customer types in the dataset?**

**18) What is the count of distinct payment methods in the dataset?**

**19) Which customer type occurs most frequently?**

**20) Identify the customer type with the highest purchase frequency.**

**21) Determine the predominant gender among customers.**

**22) Examine the distribution of genders within each branch.**

**23) Identify the time of day when customers provide the most ratings.**

**24) Determine the time of day with the highest customer ratings for each branch.**

**25) Identify the day of the week with the highest average ratings.**

**26) Determine the day of the week with the highest average ratings for each branch.**


# :green_book: **Task (Analysis List) :**

1. **Product Analysis :**

  - Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. **Sales Analysis :**
   
  - This analysis aims to answer the question of the sales trends of product. The result of this can help us measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.
 
3. **Customer Analysis :**

  - This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.



# :key: **Approach Used :**

## :paperclip: **1. Data Wrangling:**

**Data wrangling** is a crucial step in ensuring the quality and reliability of data for analysis. In this project, I focused on collecting, cleaning, and transforming raw data from multiple sources, addressing inconsistencies, missing values, and errors.This process involved using MySQL for efficient manipulation of large datasets, allowing for smooth integration into the analytical pipeline.


By structuring the data in a standardized format, I enabled seamless exploration, visualization, and extraction of valuable insights.
This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace missing or NULL values.

### **1.1 Build a database :**

- created a base named” Amazon_data "

        CREATE DATABASE Amazon_Data; -- CREATED A DATABASE
        USE Amazon_Data; -- SELECT DATABASE
        
------------------------------------------------------------------------------------------------------------------------------------------------
  
### **1.2 Create a table and insert the data :**

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


------------------------------------------------------------------------------------------------------------------------------------------------

### **1.3 Select columns with null values in them. There are no null values in our database as. in creating the tables, we set NOT NULL for each field, hence null values are filtered out.**

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
          
          -- OR
          
          DESCRIBE Amazon;


------------------------------------------------------------------------------------------------------------------------------------------------

## :paperclip: **2. Feature Engineering :** 


This will help us generate some new columns from existing ones. In this project, I implemented feature engineering techniques to derive new insights from transactional sales data using MySQL.
In this project, I performed feature engineering using MySQL to extract new insights from transactional data. I added a time_of_day column to classify sales into Morning, Afternoon, and Evening, helping identify peak sales times. A day name column was created using the DAYNAME() function to track which days of the week see the most activity.


Additionally, I added a month name column using the MONTHNAME() function to analyze monthly sales trends. These features provided valuable insights into customer behavior and sales patterns across different time frames.By adding key columns, I enhanced the dataset to answer critical business questions about sales trends.


### **2.1 ) Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.**


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


---------------------------------------------------------------------------------------------------------------------------------------------------

### **2.2 ) Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.**


          Update Amazon
          SET day_name=DAYNAME(date);

          SELECT * FROM Amazon;-- CHECKING THE TABLE AS PER REQUIREMENTS
          SELECT count(*) as null_check_day_name FROM Amazon
          WHERE day_name IS NULL; -- CHECKING IF NOT THE CODE IS PROPERLY IMPLEMENTED


          SELECT DISTINCT(MONTHNAME(date)) FROM Amazon; -- CHECKING DISTINCT DAY OF WEEK

-- Added a new column as ”DayName” at the last of the table using Dayname with Date function the field is filled. There was 5 distinct values Monday, Tuesday, Wednesday, Thursday, and Friday.


-----------------------------------------------------------------------------------------------------------------------------------------------------


### **2.3 ) Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.**
          
          
          ALTER TABLE Amazon                     -- ADDING COLUMNS FRO MONTH NAME
          ADD month_name VARCHAR(30);


          Update Amazon -- Adding filling the rows with values
          SET month_name=MONTHNAME(date);

          SELECT * FROM Amazon;                 -- CHECKING ADDED COLUMN

          SET SQL_SAFE_UPDATES=1; -- SAFE MODE ON 

          SELECT COUNT(month_name) as null_check_month_name  FROM Amazon
          WHERE month_name IS NULL;              -- CHECKING FOR ANY NULL VALUE


-- using the MONTHNAME is used with date to get month from date and get the column filled with all values. There are January, February and March.


-------------------------------------------------------------------------------------------------------------------------------------------------------------

# :key: **Business Questions To Answer :**


### **1) What is the count of distinct cities in the dataset?**


        SELECT COUNT(DISTINCT(city)) as Count_Distinct_City 
        FROM Amazon;
   
-- Count of distinct city is 3 ( Yangon, Naypyitaw , Mandalay)

-----------------------------------------------------------------------------------------------------------------------------------------------------

### **2) For each branch, what is the corresponding city?**
 
         SELECT Branch,City as Corresponding_City from Amazon 
         GROUP BY Branch,City
         ORDER BY Branch,City;


-- Each branch has only one city to each branch . Branch A- Yangon, Branch C- Naypyitaw , Branch B-Mandalay respectively

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **3) What is the count of distinct product lines in the dataset?**

       SELECT COUNT(DISTINCT (product_line)) as Distinct_Product_Line_Count 
       FROM amazon;


-- There are 6 distinct product line count (Health and Beauty, Electronics accessories, Sport and travel, Home and lifestyle, Food and Beverages, Fashion accessories)


-----------------------------------------------------------------------------------------------------------------------------------------------------


### **4) Which payment method occurs most frequently?**


       SELECT payment_method,count(payment_method) as count_of_payment 
       FROM Amazon
       GROUP BY payment_method
       ORDER BY count(payment_method) DESC;

-- Most payment method is Cash followed by E-wallet , Credit cash.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **5) Which product line has the highest sales?**
       
       
       SELECT Product_line,SUM(cogs) as Sales  
       FROM Amazon
       GROUP BY Product_line
       ORDER BY SUM(cogs) DESC;
       
-- Highest sales is done by Food and Beverages followed by Fashion accessories, Sport and travel, Home and lifestyle, Electronics accessories and Health and Beauty has lowest sales.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **6) How much revenue is generated each month?**
        
        
        SELECT Month_Name,SUM(unit_price*quantity) as Revenue
        FROM Amazon
        GROUP BY Month_Name
        ORDER BY Revenue DESC;

-- Highest revenue is earned in January Followed by March and February.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **7) In which month did the cost of goods sold reach its peak?**
    
        
        SELECT Month_Name,SUM(cogs)  as total_cogs
        FROM Amazon
        GROUP BY Month_Name
        ORDER BY SUM(cogs) DESC;

-- January is the highest revenue month followed by March and February. This analysis can be get by summing cogs(Cost Of Goods sold ) by grouping the month. There are only 3 months January, February and March.
 
-----------------------------------------------------------------------------------------------------------------------------------------------------


### **8) Which product line generated the highest revenue?**
        
        
        SELECT Product_Line,SUM(unit_price*quantity) as Revenue
        FROM Amazon
        GROUP BY Product_Line
        ORDER BY Revenue DESC;

-- We have calculate summed the unit price and quantity get revenue and order by Revenue . As Food and beverages has generate the highest revenue followed by fashion accessories ,Sport & travel ,home & life style , Electronics & accessories and Health & beauty.


-----------------------------------------------------------------------------------------------------------------------------------------------------


### **9) In which city was the highest revenue recorded?**
        
        
        SELECT City,sum(unit_price*quantity) as Revenue 
        FROM amazon
        GROUP BY City 
        ORDER BY Revenue DESC;

-- As mentioned above, we calculate revenue by adding gross income and cost of sold goods has arranged in descending to get city with highest revenue which is Naypyitaw Followed by Yangon ,Mandalay.


-----------------------------------------------------------------------------------------------------------------------------------------------------


### **10) Which product line incurred the highest Value Added Tax?**
        
        
        SELECT Product_line , round(SUM(VAT),2) as Value_Added_Tax
        FROM amazon
        GROUP BY Product_Line 
        ORDER BY Value_Added_Tax DESC;

-- As the vat is given which is grouped by product line get us insight that the Food & beverages Followed by accessories Sport & travel, Home & travel Electronics accessories, and Health & beauty.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **11) Which product line is most frequently associated with each gender?**


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

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **12) Calculate the average rating for each product line?**
        
        
        SELECT Product_line,round(AVG(rating),2) as AVG_Rating
        FROM amazon 
        GROUP BY Product_Line
        ORDER BY AVG(rating) DESC;

-- The highest average rating for product line is Food & beverages followed by Fashion accessories, Health & beauty, Electronics accessories , Sport & travel and Home & lifestyle.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **13) Count the sales occurrences for each time of day on every weekday?**
        
        
        SELECT day_name,time_of_day,COUNT(cogs) as sales_occurence 
        FROM amazon
        GROUP BY day_name,time_of_day
        ORDER BY day_name,sales_occurence DESC;

-- The highest sales occurrences at Saturday(Evening) followed by Tuesday(Evening),Wednesday(Afternoon).

-----------------------------------------------------------------------------------------------------------------------------------------------------


 ### **14) Identify the customer type contributing the highest revenue?**


        SELECT customer_type,SUM(unit_price*quantity) AS Revenue
        FROM amazon
        GROUP BY customer_type
        ORDER BY Revenue DESC;
        
-- There are only two customer type as member and normal but as per revenue member customer type generate more revenue than normal customer type around 4% more than normal member type.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **15) Determine the city with the highest VAT percentage?**


        SELECT DISTINCT city,round(SUM(VAT) over(Partition by city),2) as VAT_total,round((SUM(VAT) over(Partition by city)/SUM(VAT) over()*100),2) AS 
        VAT_percentage
        FROM amazon
        ORDER BY VAT_percentage DESC;


-- As the cities is arranged in the highest VAT are Naypyitaw after that Yangon and Mandalay. Yangon and Mandalay had the similar percentage but the value of Yangon is higher then Mandalay.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **16) Identify the customer type with the highest VAT payments?**


      SELECT customer_type,sum(VAT) AS TOTAL_VAT
      FROM amazon
      GROUP BY customer_type
      ORDER BY TOTAL_VAT DESC;

-- There is a small difference between only 2 customer type which is normal and member type . Member has sightly higher value which is around 300 more than normal customer type VAT value.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **17) What is the count of distinct customer types in the dataset?**

 
       SELECT customer_type,COUNT(DISTINCT(customer_type)) AS CUSTOMER_TYPE
       FROM amazon
       GROUP BY customer_type;

-- There are only 2 customer type Member and Normal customer type.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **18) What is the count of distinct payment methods in the dataset?**

  
      SELECT COUNT(DISTINCT(payment_method)) AS PAYMENT_METHOD  
      FROM amazon;
      
-- There is only 3 payment method which is E-wallet, cash and credit card


-----------------------------------------------------------------------------------------------------------------------------------------------------


### **19) Which customer type occurs most frequently?**


       SELECT customer_type,COUNT(customer_type) AS COUNT_CUSTOMER_TYPE 
       FROM amazon
       GROUP BY customer_type
       ORDER By COUNT_CUSTOMER_TYPE DESC;

-- There are normal and member customer type but there are 3 members customer type than normal customer type.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **20) Identify the customer type with the highest purchase frequency?**


      SELECT Customer_type,COUNT(invoice_id) as purcahse_frequency
      FROM AMAZON 
      GROUP BY customer_type
      ORDER BY purcahse_frequency DESC;

-- There are normal and member customer type but there are 3 members customer type than normal customer type.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **21) Determine the predominant gender among customers?**


      SELECT customer_type,gender,COUNT(invoice_id) as id_count
      FROM AMAZON 
      GROUP BY gender,customer_type
      ORDER BY customer_type,id_count DESC;
      
-- In member customer type, there are female are predominant than male and in normal customer type, there are male are predominant than female.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **22) Examine the distribution of genders within each branch?**


       SELECT BRANCH,GENDER,COUNT(GENDER) AS GENDER_SUM
       FROM amazon
       GROUP BY BRANCH,GENDER
       ORDER BY BRANCH, GENDER_SUM DESC;
       
-- Gender distribution among branch A has male has 179 members and Female 160 members, branch B has male has 169 members and Female 160 members, and So branch A has Female has 177 members and Female 150 members

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **23) Identify the time of day when customers provide the most ratings?**


       SELECT time_of_day,round(avg(rating),2) AS avg_rating 
       FROM amazon 
       GROUP BY time_of_day
       ORDER BY avg_rating DESC;
       
-- As per data, Afternoon has highest average rating has 7.02 rating followed by Morning and Evening

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **24) Determine the time of day with the highest customer ratings for each branch?**
    
    
         SELECT branch,time_of_day,MAX(rating) AS MAX_Rating 
         FROM amazon 
         GROUP BY branch,time_of_day
         ORDER  BY branch;
         
-- For every branch there is a time of day in which the highest rating is given 9.9 rating at each time of day for each branch has given 9.9 rating ones in every time of day.

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **25) Identify the day of the week with the highest average ratings?**


        SELECT day_name,round(avg(rating),2) as AVG_RATING
        FROM amazon
        GROUP BY day_name
        ORDER BY AVG_RATING DESC;

        
-- Monday has highest average rating 7.13 rating followed by Friday(7.06), Tuesday(7.00) , Sunday(6.99) , Saturday(6.90) ,Thursday(6.89) and Wednesday(6.76).

-----------------------------------------------------------------------------------------------------------------------------------------------------


### **26) Determine the day of the week with the highest average ratings for each branch?**

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

-- For branch A , Friday(7.31) as highest average rating followed byMonday(7.10) ,Sunday, Tuesday, Thursday, Wednesday and Saturday.
For Branch B, Monday (7.27) as highest average rating followed by Tuesday, Sunday, Thursday, Saturday, Friday, Wednesday .
For Branch C, Saturday(7.23) as highest average rating followed by Friday, Wednesday, Monday , Sunday, Tuesday, and Thursday .


-----------------------------------------------------------------------------------------------------------------------------------------------------


# :key: Analysis List


### :key: Product Analysis
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.


**CODE**


    SELECT Product_line, round(AVG(quantity),2) as AVG_quantity_product,round(AVG(rating),2) as avg_rating,SUM(unit_price*quantity) as revenue,SUM(cogs) as cost_good_sold_sum
    FROM Amazon GROUP BY Product_Line;
   

### **Output :**

![Screen Shot 2024-10-10 at 11 26 05 AM](https://github.com/user-attachments/assets/6d957f6a-5489-43ad-bdb7-d0ae82714bb9)


### **Key Insights :**

- **Best Performing Product Line :** Beauty Products (based on highest revenue and rating).

- **Product Line Needing Improvement :** Sports Equipment (lowest revenue and rating).
  
### **Recommendations :**
  
- **1. Improve Profit Margins :** The most critical concern is that revenue and cost are nearly the same across all product lines. Focus on optimizing the supply chain and reducing the cost of goods sold (COGS) to increase profitability.

- **2. Promote High-Rated Products :** Food and Beverages have the highest rating (7.11), which indicates customer satisfaction. Consider marketing these products more aggressively to boost sales and revenue.

- **3. Review Pricing Strategy :** Evaluate whether the pricing strategy for all product lines is appropriate. Small price adjustments could improve revenue without significant impact on quantity sold.

- **4. Focus on Best Performers :** Products like Fashion Accessories and Food and Beverages have strong customer ratings. Consider increasing inventory or introducing similar products to capitalize on the demand.

- **5. Low Performers :** Health and Beauty are products generate the lowest revenue despite having a high rating. This might indicate either a low market reach or pricing issues. It might be beneficial to investigate why this line is underperforming and make strategic changes, such as promotions or discounts to increase sales.

-----------------------------------------------------------------------------------------------------------------------------------------------------

### :key: Sales Analysis
This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.



    SELECT month_name,SUM(unit_price*quantity) as monthly_revenue, SUM(gross_income) as total_gross_income 
    from Amazon 
    GROUP BY month_name 
    ORDER BY month_name desc ; 

### **Output :**

![Screen Shot 2024-10-10 at 11 33 29 AM](https://github.com/user-attachments/assets/3eb718fa-6eb8-466b-ac62-b2f3e793c826)


### **Key Insights :**

**Monthly Revenue and Gross Income :**

  - **January** generated the **highest monthly revenue** of 110,754.16 and total gross income of 5,537.95.
  - **March followed** with a monthly revenue of 103,683.00 and a total gross income of 5,184.38.
  - **February** recorded the **lowest monthly revenue** of 91,168.93 and a total gross income of 4,558.65.

- January appears to be the strongest month in terms of sales performance, while February lags behind. This could suggest a need to boost sales or marketing efforts in February to bring it on par with other months.
 
### **Recommendations :**


- **1. Analyze January's Success :** Since January had the highest revenue and gross income, it would be beneficial to analyze the factors that contributed to its success. Were there any specific marketing campaigns, discounts, or new product launches that drove sales? Replicating these strategies in future months could help maintain or increase revenue.


- **2. Focus on Improving February's Sales :** February showed a considerable drop in revenue compared to January. Investigate whether external factors (seasonality, holidays, etc.) influenced this dip. If the decline is due to a lack of promotions or product availability, consider implementing targeted sales strategies during this period next year.


- **3. Sustain Momentum in March :** Although March performed slightly below January, it still had a strong showing. Focus on sustaining this trend by maintaining customer engagement and promotions throughout the quarter.

  
- **4. Seasonal Adjustments :** If seasonality plays a role, explore if any product lines are more suitable for certain months. For instance, promote high-demand items or discounts during months like February to counterbalance lower sales trends.


-----------------------------------------------------------------------------------------------------------------------------------------------------

### :key: Customer Analysis

This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.


    SELECT gender,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  gender ;


    SELECT customer_type,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  customer_type ;


    SELECT customer_type,gender,round(AVG(unit_price* quantity),2) as avg_order_value FROM Amazon group by  customer_type,gender ;



### **Output :**

![Screen Shot 2024-10-10 at 11 37 13 AM](https://github.com/user-attachments/assets/e2b2a37a-0240-4677-89db-bd2df7a93106)


### **Key Insights :**


Based on the screenshots you've provided, here are some key insights from the sales data:


**Monthly Revenue and Gross Income :**

  - January generated the highest monthly revenue of 110,754.16 and total gross income of 5,537.95.

  - March followed with a monthly revenue of 103,683.00 and a total gross income of 5,184.38.

  - February recorded the lowest monthly revenue of 91,168.93 and a total gross income of 4,558.65.

- January appears to be the strongest month in terms of sales performance, while February lags behind. This could suggest a need to boost sales or marketing efforts in February to bring it on par with other months.


**Average Order Value by Gender :**

  - Female customers have a higher average order value (318.85) compared to Male customers (295.46).

  - Female customers tend to spend more on average, which could suggest targeting more products or marketing campaigns specifically designed to appeal to female customers.


**Average Order Value by Customer Type :**

  - Members have a higher average order value (312.29) compared to Normal customers (301.96).

  - Customers who are members tend to spend more per order than non-members. This suggests that encouraging more customers to join membership programs could lead to higher average order values.


**Combined Customer Type and Gender Analysis :**

  - Female Members have the highest average order value (321.93), followed by Normal Female customers (315.50).

  - Normal Male customers have an average order value of 289.48, while Male Members have an average order value of 301.89.
  
- Female members represent the most valuable customer segment in terms of average spending. Membership programs seem to positively impact both genders but are more effective with female customers. This insight could inform targeted loyalty programs and membership promotions, especially towards females.


### **Recommendations :**

- **1. Focus on Female Customers :** Since female customers, particularly members, are showing the highest average order value, consider implementing loyalty programs, personalized marketing, or promotions specifically targeting this segment to further drive sales.

  
- **2. Increase Male Customer Engagement :** Males, particularly normal customers, have the lowest average order value. It may be beneficial to explore why this segment lags in spending. Offering targeted promotions, special deals, or enhancing the membership benefits for males could encourage higher spending.

  
- **3. Strengthen Membership Programs :** Members, in general, are spending more than normal customers. Highlighting the benefits of membership to non-member customers might lead to increased sign-ups, as well as higher average order values.
 
     
- **4. Tailored Marketing for Segments :** Craft gender-specific and membership-focused marketing strategies to tap into the higher spending behavior of certain segments. For example, providing female customers with product recommendations based on their purchase history or preferences could result in an increased order value.

-----------------------------------------------------------------------------------------------------------------------------------------------------


# 🛠️ **Final Recommnedation :** 🛠️


- **1. Enhance Targeted Marketing for Female Customers :** Female customers, both members and normal, exhibit higher average order values. Tailor marketing strategies to engage this group more effectively through personalized promotions, exclusive offers, and targeted campaigns. Focus on retaining these high-value customers by providing them with product recommendations and personalized experiences based on their preferences and purchase history.


- **2. Promote Membership Programs :** Members, particularly females, spend more than normal customers. To increase the customer base and average order value, promote membership benefits through attractive incentives such as loyalty rewards, exclusive deals, and early access to sales. Encourage non-members to join by highlighting how membership leads to savings and access to premium products.


- **3. Increase Engagement Among Male Customers :** Male customers, especially normal ones, have lower average order values. Focus on increasing male customer engagement through targeted discounts, product bundles, or personalized promotions aimed at their specific interests. Offering incentives like discounts for higher spending or promoting membership could help drive up their order values.


- **4. Leverage Cross-Selling and Upselling Techniques :** For all customer segments, particularly the lower-spending male group, introduce cross- selling and upselling strategies. Suggest complementary products at checkout or offer special discounts for higher-value purchases. This can increase average order values and overall profitability across the board.



-----------------------------------------------------------------------------------------------------------------------------------------------------


# 🔍 **Conclusion :** 🔍

The customer analysis reveals important insights into purchasing trends across different customer segments, specifically in terms of gender and membership status. Female customers, particularly members, exhibit the highest average order values, making them a key segment for the business to target with personalized and loyalty-driven marketing strategies. On the other hand, male customers, especially non-members, spend less on average, indicating an opportunity to engage them more effectively through targeted promotions and incentives.


By enhancing membership programs, focusing on cross-selling and upselling techniques, and leveraging tailored marketing campaigns, the business can capitalize on the higher spending behavior of certain customer groups while working to improve engagement and order values among lower-performing segments. These strategies will help boost revenue, improve customer retention, and ensure more effective sales efforts across all segments.


Overall, this analysis serves as a foundation for implementing data-driven decisions that can improve both customer satisfaction and business profitability.



