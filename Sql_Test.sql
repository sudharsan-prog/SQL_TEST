select top 20* from Assessment_TE;

select * from Assessment_TE;

--Rounded the TransactionAmount to the nearest whole number
SELECT ROUND(TransactionAmount, 0) AS RoundedTransactionAmount 
FROM Assessment_TE;


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

--Most sold product based on customerage
WITH AgeGroupSales AS (
    SELECT 
        ProductName,
        CASE 
            WHEN CustomerAge < 30 THEN 'Below 30'
            WHEN CustomerAge > 30 THEN 'Above 30'
        END AS AgeGroup,
        COUNT(*) AS TotalSales
    FROM Assessment_TE
    WHERE CustomerAge IS NOT NULL
    GROUP BY ProductName, CustomerAge
),
RankedProducts AS (
    SELECT 
        AgeGroup, 
        ProductName, 
        TotalSales,
        RANK() OVER (PARTITION BY AgeGroup ORDER BY TotalSales DESC) AS SalesRank
    FROM AgeGroupSales
    WHERE AgeGroup IS NOT NULL
)
SELECT AgeGroup, ProductName, TotalSales
FROM RankedProducts
WHERE (AgeGroup = 'Above 30' AND SalesRank = 1) 
   OR (AgeGroup = 'Below 30' AND (ProductName IS NOT NULL AND SalesRank = 2))
ORDER BY AgeGroup, SalesRank;

