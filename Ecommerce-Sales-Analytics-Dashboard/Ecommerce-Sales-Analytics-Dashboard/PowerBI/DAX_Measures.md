# DAX Measures Reference

All measures below live in a dedicated **_Measures** table in the Power BI model
(best practice: keep calculated measures out of physical data tables). Create the
table via *Modeling → New Table* with a single dummy column, then add each
measure through *New Measure*.

---

## Core KPIs

```dax
Total Sales =
SUM ( Sales[SalesAmount] )
```

```dax
Total Profit =
SUM ( Sales[ProfitAmount] )
```

```dax
Profit Margin % =
DIVIDE ( [Total Profit], [Total Sales], 0 )
```

```dax
Total Orders =
DISTINCTCOUNT ( Sales[OrderID] )
```

```dax
Average Order Value (AOV) =
DIVIDE ( [Total Sales], [Total Orders], 0 )
```

```dax
Total Units Sold =
SUM ( Sales[Quantity] )
```

```dax
Total Cost =
SUM ( Sales[CostAmount] )
```

---

## Time Intelligence

> Requires an active relationship between `Sales[DateKeyInt]` and
> `Date_Dimension[DateKeyInt]`, and `Date_Dimension` marked as the official
> **Date Table** (Modeling → Mark as Date Table, using the `Date` column).

```dax
Sales PY (Prior Year) =
CALCULATE (
    [Total Sales],
    SAMEPERIODLASTYEAR ( Date_Dimension[Date] )
)
```

```dax
YoY Sales Growth % =
VAR CurrentSales = [Total Sales]
VAR PriorYearSales = [Sales PY (Prior Year)]
RETURN
    DIVIDE ( CurrentSales - PriorYearSales, PriorYearSales, BLANK() )
```

```dax
YoY Sales Growth (Value) =
[Total Sales] - [Sales PY (Prior Year)]
```

```dax
Profit PY (Prior Year) =
CALCULATE (
    [Total Profit],
    SAMEPERIODLASTYEAR ( Date_Dimension[Date] )
)
```

```dax
YoY Profit Growth % =
DIVIDE ( [Total Profit] - [Profit PY (Prior Year)], [Profit PY (Prior Year)], BLANK() )
```

```dax
Sales MTD =
TOTALMTD ( [Total Sales], Date_Dimension[Date] )
```

```dax
Sales QTD =
TOTALQTD ( [Total Sales], Date_Dimension[Date] )
```

```dax
Sales YTD =
TOTALYTD ( [Total Sales], Date_Dimension[Date] )
```

---

## Ranking & Contribution Measures (used for Top-N visuals)

```dax
Product Sales Rank =
RANKX ( ALL ( Products[ProductName] ), [Total Sales], , DESC )
```

```dax
Customer Sales Rank =
RANKX ( ALL ( Customers[CustomerName] ), [Total Sales], , DESC )
```

```dax
% of Total Sales =
DIVIDE ( [Total Sales], CALCULATE ( [Total Sales], ALL ( Products ) ), 0 )
```

```dax
% of Total Sales (Region) =
DIVIDE ( [Total Sales], CALCULATE ( [Total Sales], ALL ( Customers[Region] ) ), 0 )
```

---

## Discount & Margin Health

```dax
Total Discount =
SUM ( Sales[Discount] )
```

```dax
Discount % of Sales =
DIVIDE ( [Total Discount], [Total Sales] + [Total Discount], 0 )
```

```dax
Low Margin Flag =
IF ( [Profit Margin %] < 0.20, "⚠ Review", "Healthy" )
```

---

## Customer Measures

```dax
Total Customers =
DISTINCTCOUNT ( Sales[CustomerID] )
```

```dax
Repeat Customers =
CALCULATE (
    DISTINCTCOUNT ( Sales[CustomerID] ),
    FILTER ( VALUES ( Sales[CustomerID] ), [Total Orders] > 1 )
)
```

```dax
Avg Revenue per Customer =
DIVIDE ( [Total Sales], [Total Customers], 0 )
```

---

## Usage Notes

- All measures were **validated against the equivalent SQL query** in
  `/SQL/03_analysis_queries.sql` — totals reconcile exactly, which is what the
  résumé bullet *"Validated Power BI calculations against SQL query results"*
  refers to.
- Use `Total Sales`, `Total Profit`, `Profit Margin %`, `Total Orders`, and
  `Average Order Value (AOV)` on **KPI Cards** at the top of the report page.
- Use `YoY Sales Growth %` on a KPI card with conditional formatting (green ▲ /
  red ▼) to compare 2024 vs 2025 performance.
