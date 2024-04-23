SELECT * FROM dbo.CustomerChurn 

--NULL VALUES
SELECT COUNT(*) AS Customer_Id FROM dbo.CustomerChurn
WHERE customerID IS NULL

SELECT COUNT(*)  as Total_Charges FROM dbo.CustomerChurn
WHERE TotalCharges IS NULL

SELECT COUNT(*) FROM dbo.CustomerChurn
WHERE MonthlyCharges IS NULL

UPDATE dbo.CustomerChurn 
SET TotalCharges = (SELECT AVG(TotalCharges) from dbo.CustomerChurn)
WHERE TotalCharges IS NULL

--Checking Total no . of customers
SELECT COUNT(DISTINCT customerID) as Total_No_Of_Customers
FROM dbo.CustomerChurn

--Checking for Duplicates 
SELECT customerID , COUNT(customerID) as Total_No_Of_Customers
FROM dbo.CustomerChurn
GROUP BY customerID
HAVING COUNT(customerID) > 1
--No Duplicates found

SELECT PaymentMethod, 
COUNT(*) as count,
ROUND(COUNT(customerID)*100.0 /SUM(COUNT(*)) OVER(),2) AS ChurnRate
FROM dbo.CustomerChurn
GROUP BY PaymentMethod
ORDER BY ChurnRate DESC
--Electronic Check was used often

--Getting count of Churned and non-Churned Customers
SELECT ROUND(COUNT(customerID) *100.0/SUM(COUNT(customerID))OVER(),2) AS Customer_Count,
Churn
FROM dbo.CustomerChurn
GROUP BY Churn
--26.5 PERCENTAGE OF CUSTOMERS LEFT THE COMPANY I.E A HUGE CUSTOMERS WHO LEFT COMPANY SERVICES.


SELECT 
    CASE 
        WHEN tenure < 6 THEN '6 Months'
        WHEN tenure < 12 THEN '12 Months'
        WHEN tenure < 24 THEN '24 Months'
        WHEN tenure < 48 THEN '48 Months'
        ELSE '+4 Years'
    END AS Tenure,
    ROUND(COUNT(customerID) *100.0 /SUM(COUNT(customerID)) OVER(),2) AS Customer_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY CASE 
        WHEN tenure < 6 THEN '6 Months'
        WHEN tenure < 12 THEN '12 Months'
        WHEN tenure < 24 THEN '24 Months'
        WHEN tenure < 48 THEN '48 Months'
        ELSE '+4 Years'
    END 
ORDER BY Customer_Percentage DESC

--To get what type of Internet Service are used by churned peoples
SELECT InternetService, 
COUNT(customerID) as count,
ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 1) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY InternetService
-- 69.4 % percentage of persons used Fibre optic internet service.

--To see whether there was online security to the customer 
SELECT OnlineSecurity, 
COUNT(customerID) as count,
ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 2) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY OnlineSecurity
ORDER BY count DESC
--Online Security was not available to 78.2 % approx. so this could be reason was customer churned


--Getting Contract wise count 
SELECT Contract, 
COUNT(customerID) as count,
ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 2) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY Contract
ORDER BY count DESC
--This shows that contract period should be increased to reduce the churning rate as those who have less contract period are churning more.

SELECT 
ROUND((SUM(TotalCharges))*100 /SUM(SUM(TotalCharges)) OVER() , 2)  as Total_Charges_Percentage , 
Churn
FROM dbo.CustomerChurn
GROUP BY Churn ;
--This shows that there will be loss of 17.83 % of revenue


SELECT OnlineBackup, 
COUNT(customerID) as count,
ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 2) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY OnlineBackup
ORDER BY count DESC

SELECT StreamingMovies, 
COUNT(customerID) as count,
ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 2) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY StreamingMovies
ORDER BY count DESC
--Not dependent on churning rate 

SELECT StreamingTV, 
COUNT(customerID) as count,
ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 2) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY StreamingTV
ORDER BY count DESC
--Not dependent on churning rate 

SELECT gender, 
COUNT(customerID) as count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Churn_Percentage
FROM dbo.CustomerChurn
WHERE Churn = 'Yes'
GROUP BY gender
ORDER BY count DESC
--No Major correlation between Gender and churning rate


SELECT TOP 5 * 
from dbo.CustomerChurn
WHERE Churn = 'Yes'
ORDER BY TotalCharges DESC

--It shows the top 5 person who has maximum Total Charges in churned Population 
