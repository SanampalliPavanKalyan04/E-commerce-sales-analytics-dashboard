/* =============================================================================
   E-COMMERCE SALES ANALYTICS DASHBOARD
   Script 01: Database & Table Schema (Star Schema)
   Compatible with: MySQL 8+ / SQL Server 2016+ (minor syntax tweaks noted)
   =============================================================================
   Design:
     Sales        -> Fact table  (grain: one row per order line item)
     Customers    -> Dimension table
     Products     -> Dimension table
     Date_Dimension -> Dimension table (drives time intelligence)
   ============================================================================= */

CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Date_Dimension;

-- -----------------------------------------------------------------------------
-- DIMENSION: Customers
-- -----------------------------------------------------------------------------
CREATE TABLE Customers (
    CustomerID      VARCHAR(15)     PRIMARY KEY,
    CustomerName    VARCHAR(100)    NOT NULL,
    Region          VARCHAR(50)     NOT NULL,
    State           VARCHAR(50)     NOT NULL,
    Segment         VARCHAR(30)     NOT NULL,        -- Consumer / Corporate / Small Business
    SignupDate      DATE            NOT NULL
);

-- -----------------------------------------------------------------------------
-- DIMENSION: Products
-- -----------------------------------------------------------------------------
CREATE TABLE Products (
    ProductID       VARCHAR(15)     PRIMARY KEY,
    ProductName     VARCHAR(100)    NOT NULL,
    Category        VARCHAR(50)     NOT NULL,
    UnitCost        DECIMAL(10,2)   NOT NULL,
    UnitPrice       DECIMAL(10,2)   NOT NULL
);

-- -----------------------------------------------------------------------------
-- DIMENSION: Date_Dimension
-- -----------------------------------------------------------------------------
CREATE TABLE Date_Dimension (
    DateKeyInt      INT             PRIMARY KEY,     -- yyyymmdd, e.g. 20250131
    Date            DATE            NOT NULL,
    Day             INT             NOT NULL,
    Month           INT             NOT NULL,
    MonthName       VARCHAR(10)     NOT NULL,
    Quarter         VARCHAR(2)      NOT NULL,
    Year            INT             NOT NULL,
    WeekdayName     VARCHAR(10)     NOT NULL,
    IsWeekend       BOOLEAN         NOT NULL,
    MonthYear       VARCHAR(10)     NOT NULL
);

-- -----------------------------------------------------------------------------
-- FACT: Sales  (one row = one order line item)
-- -----------------------------------------------------------------------------
CREATE TABLE Sales (
    OrderID         VARCHAR(15)     NOT NULL,
    OrderDate       DATE            NOT NULL,
    DateKeyInt      INT             NOT NULL,
    CustomerID      VARCHAR(15)     NOT NULL,
    ProductID       VARCHAR(15)     NOT NULL,
    Quantity        INT             NOT NULL,
    UnitPrice       DECIMAL(10,2)   NOT NULL,
    Discount        DECIMAL(10,2)   NOT NULL DEFAULT 0,
    SalesAmount     DECIMAL(12,2)   NOT NULL,          -- (Qty * UnitPrice) - Discount
    CostAmount      DECIMAL(12,2)   NOT NULL,          -- Qty * UnitCost
    ProfitAmount    DECIMAL(12,2)   NOT NULL,          -- SalesAmount - CostAmount
    PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT fk_sales_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT fk_sales_product  FOREIGN KEY (ProductID)  REFERENCES Products(ProductID),
    CONSTRAINT fk_sales_date     FOREIGN KEY (DateKeyInt) REFERENCES Date_Dimension(DateKeyInt)
);

-- Helpful indexes for aggregation-heavy analytical queries
CREATE INDEX idx_sales_date     ON Sales(DateKeyInt);
CREATE INDEX idx_sales_customer ON Sales(CustomerID);
CREATE INDEX idx_sales_product  ON Sales(ProductID);
CREATE INDEX idx_customers_region ON Customers(Region);
CREATE INDEX idx_products_category ON Products(Category);
