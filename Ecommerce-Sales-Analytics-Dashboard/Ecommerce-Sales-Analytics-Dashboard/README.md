# E-commerce Sales Analytics Dashboard

An end-to-end analytics project: a relational SQL database, a Power BI star
schema data model with DAX measures, and an interactive dashboard analyzing
sales, revenue, profit, products, customers, and regional performance.

## Folder Structure

```
Ecommerce-Sales-Analytics-Dashboard/
├── README.md                          <- you are here
├── SQL/
│   ├── 01_schema.sql                  <- database + table creation (star schema)
│   ├── 02_load_data.sql               <- loads the CSVs in /Data into the DB
│   └── 03_analysis_queries.sql        <- 10 business queries (KPIs, trends, top-N, etc.)
├── Data/
│   ├── Customers.csv                  <- 250 customers
│   ├── Products.csv                   <- 31 products across 6 categories
│   ├── Date_Dimension.csv             <- 731-day calendar table (2024–2025)
│   └── Sales.csv                      <- 6,156 order line items (the fact table)
├── PowerBI/
│   ├── DAX_Measures.md                <- every DAX measure, ready to paste into Power BI
│   └── PowerBI_Setup_Guide.md         <- step-by-step: model, measures, pages, slicers
├── Documentation/
│   └── Business_Insights.md           <- actionable insights generated from the data
└── Dashboard_Preview/
    └── dashboard.html                 <- interactive HTML preview of the dashboard
```

## Project Summary

- **Database design:** A star-schema relational model with one fact table
  (`Sales`) and three dimension tables (`Customers`, `Products`,
  `Date_Dimension`), built with primary/foreign keys, indexes, joins,
  aggregations, filtering, and `GROUP BY` operations — see `/SQL`.
- **Power BI data model:** The same four tables connected in Power BI as a
  star schema, with `Date_Dimension` marked as the official Date Table to
  enable time-intelligence functions.
- **DAX measures:** Total Sales, Total Profit, Profit Margin %, Total Orders,
  Average Order Value (AOV), and Year-over-Year (YoY) Sales Growth, plus
  supporting measures for ranking, contribution %, and customer analysis —
  see `/PowerBI/DAX_Measures.md`.
- **Visualizations:** Monthly sales trend, top-selling products, category
  performance, regional sales, customer segments, and a Top-10 customers
  view — with slicers, KPI cards, drill-downs (Region → State, Year →
  Quarter → Month), and cross-filtering.
- **Validation:** Every DAX measure was checked against the equivalent SQL
  query in `03_analysis_queries.sql` to confirm the numbers reconcile
  exactly between the database and the report.
- **Insights:** See `/Documentation/Business_Insights.md` for the specific,
  numbers-backed findings this data produced (top products, margin risks,
  regional gaps, customer segment behavior, and recommended actions).

## How to Rebuild This Yourself

1. **Set up the database.** Run `SQL/01_schema.sql` in MySQL (or SQL Server,
   with minor syntax edits noted in the script) to create the tables.
2. **Load the data.** Run `SQL/02_load_data.sql`, pointing it at the CSVs in
   `/Data` (or import the CSVs directly — no database required if you'd
   rather build the Power BI model straight off the files).
3. **Run the analysis queries.** `SQL/03_analysis_queries.sql` reproduces
   every number that later appears in the dashboard — useful both as SQL
   practice and as your validation baseline.
4. **Build the Power BI report.** Follow `PowerBI/PowerBI_Setup_Guide.md`
   step by step: import the four tables, build the relationships, mark the
   date table, add the measures from `DAX_Measures.md`, then build the
   report pages, slicers, and drill-downs.
5. **Preview the dashboard now, without Power BI Desktop.** Open
   `Dashboard_Preview/dashboard.html` in any browser — it's an interactive
   HTML version of the same KPIs and charts, built directly from
   `/Data/Sales.csv`, so you (or a recruiter) can see the finished result
   immediately.

## Why This Structure

Keeping SQL, raw data, Power BI assets, documentation, and a live preview in
separate folders mirrors how a real analytics project is organized and
handed off: a reviewer can validate the numbers in SQL, rebuild the model in
Power BI using the guide, and read the business conclusions without having
to reverse-engineer any of it from a single messy file.

## Dataset Notes

The dataset is **synthetically generated** (250 customers, 31 products
across 6 categories, 6,156 orders spanning Jan 2024–Dec 2025) to closely
resemble a real mid-size e-commerce business, including realistic seasonal
patterns (a festive-season Aug–Dec peak, a February dip), regional
variation, and a mix of high-volume/low-margin and low-volume/high-margin
products — so the insights generated are the kind you would actually expect
to find and act on in a real dataset, not artificial-looking round numbers.
