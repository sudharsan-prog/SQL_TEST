Assessment Task: 
1. Explore this dataset and highlight key insights in terms of aggregate and drill 
down of this sales data. 
2. Share SQL scripts used to explore data and generate metrics & Key insights 
in bullet points via GitHub link 
----------------------------------------------------------------------------------------------------------------------------
Insights 
1 The total transaction amount sums up to ₹9,177,744,106.78, indicating significant sales volume. This figure reflects overall revenue generated from all transactions. Further analysis can help identify trends, peak sales periods, and potential growth opportunities.

2 Chennai recorded the highest transaction amount at ₹99,996.89, followed closely by Bangalore and Pune. The data suggests strong purchasing power in metro cities, with Chennai leading in high-value transactions. Further analysis can explore factors driving these top transactions, such as demand trends or customer segments.

3 The T-Shirt emerged as the most sold product, with 81,201 units sold, indicating strong demand in the apparel category. Notebooks and Apples also saw high sales, suggesting consistent consumer interest in stationery and groceries. Analyzing customer preferences can help optimize inventory and marketing strategies for top-selling products.
 
4 Debit Cards were the most used payment method, with 101,694 transactions, followed closely by UPI (101,272) and Credit Cards (100,682). This indicates a balanced preference for digital payments, with slight dominance of debit card usage. Understanding customer payment behavior can help enhance checkout experiences and offer targeted promotions

5 The average age of customers making purchases is 42 years, indicating a strong consumer base in the middle-aged demographic. This suggests that purchasing power and engagement are higher among mature customers. Tailoring marketing strategies and product offerings to this age group can enhance customer retention and sales.

6 The online store recorded the highest sales, with 1,462,001 transactions, highlighting the dominance of e-commerce. This reflects a strong consumer shift towards digital shopping, likely driven by convenience and accessibility. Optimizing online platforms, enhancing user experience, and offering targeted promotions can further boost sales.

7 October recorded the highest sales, with 120,881 transactions, indicating a peak in consumer spending during this month. This surge could be influenced by festive seasons, holiday shopping, or promotional events. Businesses can capitalize on this trend by planning targeted marketing campaigns and optimizing stock availability in October.

8 Saturday saw the highest sales, with 213,321 transactions, indicating increased weekend shopping activity. This trend suggests that customers prefer making purchases during their leisure time. Businesses can leverage this by offering special weekend promotions and optimizing inventory for peak demand.

9 

-------------------------------------------------------------------------------------------------------------------------------------------

--Calculating the sum of TransactionAmount
SELECT SUM(CAST(TransactionAmount AS FLOAT)) AS sums 
FROM Assessment_TE;


--Converted the date to a day
SELECT DATENAME(WEEKDAY, CAST(TransactionDate AS DATETIME)) AS dayname 
FROM Assessment_TE 
WHERE ISDATE(TransactionDate) = 1;


--The highest transaction occurred among the listed cities
SELECT MAX(TransactionAmount) AS MaxTransaction, city 
FROM Assessment_TE 
GROUP BY city 
ORDER BY MaxTransaction DESC;


-- The most sold product
select top 5 count (*) as sales,ProductName from Assessment_TE
group by ProductName;


--Most transactions occurred for different payment methods.
select top 3 count (*) as Transaction_1, PaymentMethod from Assessment_TE
group by PaymentMethod 
ORDER BY PaymentMethod DESC;


--Average age of the customers who made a purchase
select avg(cast(CustomerAge as Float)) as Avg_CustomerAge from Assessment_TE;


--The store type with the highest sales
SELECT TOP 1 storetype, SUM(Quantity) AS Total_Quantity_sold 
FROM Assessment_TE 
GROUP BY storetype 
ORDER BY Total_Quantity_sold DESC;


--Which month had the highest sales
SELECT TOP 1 
    MONTH(CAST(TransactionDate AS DATETIME)) AS TopMonth, 
    DATENAME(MONTH, CAST(TransactionDate AS DATETIME)) AS MonthName, 
    SUM(Quantity) AS Total_Quantity_Sold
FROM Assessment_TE
WHERE ISDATE(TransactionDate) = 1  -- Ensure valid date values
GROUP BY MONTH(CAST(TransactionDate AS DATETIME)), DATENAME(MONTH, CAST(TransactionDate AS DATETIME))
ORDER BY Total_Quantity_Sold DESC;


--Which day has the highest sales
SELECT TOP 1 
    DATENAME(WEEKDAY, CAST(TransactionDate AS DATETIME)) AS TopDay, 
    SUM(Quantity) AS Total_Quantity_Sold
FROM Assessment_TE
WHERE ISDATE(TransactionDate) = 1  -- Ensure valid date values
GROUP BY DATENAME(WEEKDAY, CAST(TransactionDate AS DATETIME))
ORDER BY Total_Quantity_Sold DESC;
