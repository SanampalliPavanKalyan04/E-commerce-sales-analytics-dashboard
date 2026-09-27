/* =============================================================================
   Script 03: Business Analysis Queries
   These mirror every KPI/visual built in Power BI, so results here were used
   to validate the DAX measures (see /PowerBI/DAX_Measures.md).
   ============================================================================= */

USE ecommerce_analytics;

-- -----------------------------------------------------------------------------
-- 1. CORE KPIs — Total Sales, Total Profit, Profit Margin, Total Orders, AOV
-- -----------------------------------------------------------------------------
SELECT
    ROUND(SUM(SalesAmount), 2)                         AS Total_Sales,
    ROUND(SUM(ProfitAmount), 2)                        AS Total_Profit,
    ROUND(SUM(ProfitAmount) * 100.0 / SUM(SalesAmount), 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT OrderID)                            AS Total_Orders,
    ROUND(SUM(SalesAmount) / COUNT(DISTINCT OrderID), 2)   AS Avg_Order_Value
FROM Sales;

-- -----------------------------------------------------------------------------
-- 2. MONTHLY SALES TREND
-- -----------------------------------------------------------------------------
SELECT
    d.Year,
    d.Month,
    d.MonthName,
    ROUND(SUM(s.SalesAmount), 2) AS Monthly_Sales,
    ROUND(SUM(s.ProfitAmount), 2) AS Monthly_Profit,
    COUNT(DISTINCT s.OrderID) AS Orders
FROM Sales s
JOIN Date_Dimension d ON s.DateKeyInt = d.DateKeyInt
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

-- -----------------------------------------------------------------------------
-- 3. YEAR-OVER-YEAR (YoY) SALES GROWTH
-- -----------------------------------------------------------------------------
WITH yearly_sales AS (
    SELECT d.Year, SUM(s.SalesAmount) AS Total_Sales
    FROM Sales s
    JOIN Date_Dimension d ON s.DateKeyInt = d.DateKeyInt
    GROUP BY d.Year
)
SELECT
    Year,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Year) AS Prior_Year_Sales,
    ROUND(
        (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Year)) * 100.0
        / LAG(Total_Sales) OVER (ORDER BY Year), 2
    ) AS YoY_Growth_Pct
FROM yearly_sales
ORDER BY Year;

-- -----------------------------------------------------------------------------
-- 4. TOP 10 SELLING PRODUCTS (by revenue)
-- -----------------------------------------------------------------------------
SELECT
    p.ProductName,
    p.Category,
    SUM(s.Quantity)               AS Units_Sold,
    ROUND(SUM(s.SalesAmount), 2)  AS Total_Revenue,
    ROUND(SUM(s.ProfitAmount), 2) AS Total_Profit
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName, p.Category
ORDER BY Total_Revenue DESC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- 5. CATEGORY PERFORMANCE
-- -----------------------------------------------------------------------------
SELECT
    p.Category,
    ROUND(SUM(s.SalesAmount), 2)   AS Total_Sales,
    ROUND(SUM(s.ProfitAmount), 2)  AS Total_Profit,
    ROUND(SUM(s.ProfitAmount) * 100.0 / SUM(s.SalesAmount), 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT s.OrderID)      AS Orders
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

-- -----------------------------------------------------------------------------
-- 6. REGIONAL SALES PERFORMANCE
-- -----------------------------------------------------------------------------
SELECT
    c.Region,
    ROUND(SUM(s.SalesAmount), 2)  AS Total_Sales,
    ROUND(SUM(s.ProfitAmount), 2) AS Total_Profit,
    COUNT(DISTINCT s.OrderID)     AS Orders,
    COUNT(DISTINCT c.CustomerID)  AS Customers
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.Region
ORDER BY Total_Sales DESC;

-- -----------------------------------------------------------------------------
-- 7. TOP 10 CUSTOMERS (by revenue)
-- -----------------------------------------------------------------------------
SELECT
    c.CustomerName,
    c.Region,
    c.Segment,
    COUNT(DISTINCT s.OrderID)     AS Orders_Placed,
    ROUND(SUM(s.SalesAmount), 2)  AS Total_Spend,
    ROUND(SUM(s.ProfitAmount), 2) AS Total_Profit_Generated
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName, c.Region, c.Segment
ORDER BY Total_Spend DESC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- 8. CUSTOMER SEGMENT ANALYSIS
-- -----------------------------------------------------------------------------
SELECT
    c.Segment,
    COUNT(DISTINCT c.CustomerID)  AS Customers,
    COUNT(DISTINCT s.OrderID)     AS Orders,
    ROUND(SUM(s.SalesAmount), 2)  AS Total_Sales,
    ROUND(SUM(s.SalesAmount) / COUNT(DISTINCT s.OrderID), 2) AS Avg_Order_Value
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;

-- -----------------------------------------------------------------------------
-- 9. LOW-MARGIN / UNDERPERFORMING PRODUCTS (for action)
-- -----------------------------------------------------------------------------
SELECT
    p.ProductName,
    p.Category,
    ROUND(SUM(s.SalesAmount), 2)  AS Total_Sales,
    ROUND(SUM(s.ProfitAmount) * 100.0 / SUM(s.SalesAmount), 2) AS Profit_Margin_Pct
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName, p.Category
HAVING Profit_Margin_Pct < 20
ORDER BY Profit_Margin_Pct ASC;

-- -----------------------------------------------------------------------------
-- 10. WEEKEND vs WEEKDAY SALES BEHAVIOUR
-- -----------------------------------------------------------------------------
SELECT
    d.IsWeekend,
    COUNT(DISTINCT s.OrderID)    AS Orders,
    ROUND(SUM(s.SalesAmount),2)  AS Total_Sales,
    ROUND(AVG(s.SalesAmount),2)  AS Avg_Line_Value
FROM Sales s
JOIN Date_Dimension d ON s.DateKeyInt = d.DateKeyInt
GROUP BY d.IsWeekend;
