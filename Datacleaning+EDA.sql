SELECT TOP 100 * FROM dbo.CustomerData;
SELECT CustomerID, FullName, Age
FROM dbo.CustomerData
WHERE Age IS NULL OR Age < 10 OR Age > 100;
UPDATE dbo.CustomerData
SET Age = NULL
WHERE Age < 10 OR Age > 100;
WITH MedianCTE AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Age) OVER () AS MedianAge
    FROM dbo.CustomerData
    WHERE Age IS NOT NULL
)
UPDATE C
SET Age = M.MedianAge
FROM dbo.CustomerData C
CROSS APPLY (SELECT TOP 1 MedianAge FROM MedianCTE) M
WHERE C.Age IS NULL;
UPDATE dbo.CustomerData
SET Gender = CASE
    WHEN Gender IN ('F', 'Female', 'female') THEN 'Female'
    WHEN Gender IN ('M', 'Male', 'MALE', 'male') THEN 'Male'
    ELSE 'Unknown'
END;

UPDATE dbo.CustomerData
SET Income = NULL
WHERE Income IS NULL OR Income < 0;

WITH IncomeMedian AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Income) OVER () AS MedianIncome
    FROM dbo.CustomerData
    WHERE Income IS NOT NULL
)
UPDATE D
SET Income = M.MedianIncome
FROM dbo.CustomerData D
CROSS APPLY (SELECT TOP 1 MedianIncome FROM IncomeMedian) M
WHERE D.Income IS NULL;

UPDATE dbo.CustomerData
SET PurchaseFrequency = CASE
    WHEN PurchaseFrequency IN ('monthly', 'Monthly') THEN 'Monthly'
    WHEN PurchaseFrequency IN ('weekly', 'Weekly') THEN 'Weekly'
    WHEN PurchaseFrequency IN ('Yearly', 'yearly', 'Annually') THEN 'Yearly'
    WHEN PurchaseFrequency IS NULL OR PurchaseFrequency = '' THEN 'Unknown'
    ELSE PurchaseFrequency
END;

UPDATE dbo.CustomerData
SET Churned = CASE
    WHEN Churned IN ('Y', 'Yes', 'yes') THEN 'Yes'
    WHEN Churned IN ('N', 'No', 'no') THEN 'No'
    ELSE 'Unknown'
END;

UPDATE dbo.CustomerData
SET SatisfactionScore = NULL
WHERE SatisfactionScore < 1 OR SatisfactionScore > 10;
WITH ScoreMedian AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY SatisfactionScore) OVER () AS MedianScore
    FROM dbo.CustomerData
    WHERE SatisfactionScore IS NOT NULL
)
UPDATE D
SET SatisfactionScore = S.MedianScore
FROM dbo.CustomerData D
CROSS APPLY (SELECT TOP 1 MedianScore FROM ScoreMedian) S
WHERE D.SatisfactionScore IS NULL;

WITH Deduped AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY CustomerID, FullName, Age, Income, Region, PurchaseFrequency
               ORDER BY CustomerID) AS RowNum
    FROM dbo.CustomerData
)
DELETE FROM Deduped WHERE RowNum > 1;

SELECT Region, COUNT(*) AS CustomerCount
FROM dbo.CustomerData
GROUP BY Region
ORDER BY CustomerCount DESC;

SELECT Region, AVG(Income) AS AvgIncome
FROM dbo.CustomerData
GROUP BY Region;

SELECT PurchaseFrequency, 
       AVG(SatisfactionScore) AS AvgSatisfaction,
       COUNT(*) AS TotalCustomers
FROM dbo.CustomerData
GROUP BY PurchaseFrequency;

SELECT Churned, COUNT(*) AS NumCustomers
FROM dbo.CustomerData
GROUP BY Churned;
