/* =============================================================================
   Script 02: Load Sample Data
   The /Data folder contains ready-made CSVs (Customers.csv, Products.csv,
   Date_Dimension.csv, Sales.csv) generated for this project.

   OPTION A — MySQL (LOAD DATA INFILE)
   Adjust the path to wherever you copy the CSV files on your machine, and make
   sure `secure_file_priv` / local_infile settings allow it.
   ============================================================================= */

USE ecommerce_analytics;

LOAD DATA LOCAL INFILE 'Data/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerID, CustomerName, Region, State, Segment, SignupDate);

LOAD DATA LOCAL INFILE 'Data/Products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID, ProductName, Category, UnitCost, UnitPrice);

LOAD DATA LOCAL INFILE 'Data/Date_Dimension.csv'
INTO TABLE Date_Dimension
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Date, Day, Month, MonthName, Quarter, Year, WeekdayName, IsWeekend, MonthYear, DateKeyInt);

LOAD DATA LOCAL INFILE 'Data/Sales.csv'
INTO TABLE Sales
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, OrderDate, DateKeyInt, CustomerID, ProductID, Quantity, UnitPrice,
 Discount, SalesAmount, CostAmount, ProfitAmount);

/* -----------------------------------------------------------------------------
   OPTION B — SQL Server (BULK INSERT)
   BULK INSERT Customers FROM 'C:\Data\Customers.csv'
       WITH (FORMAT='CSV', FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n');
   -- repeat for Products, Date_Dimension, Sales
----------------------------------------------------------------------------- */

-- Quick sanity checks after loading
SELECT COUNT(*) AS Customers_Loaded FROM Customers;
SELECT COUNT(*) AS Products_Loaded  FROM Products;
SELECT COUNT(*) AS Dates_Loaded     FROM Date_Dimension;
SELECT COUNT(*) AS Sales_Loaded     FROM Sales;
