# 📊 E-commerce Sales Analytics Dashboard

An end-to-end business intelligence project analyzing sales, profit, products, 
customers, and regional performance for an e-commerce business — built with 
**SQL, Power BI, and DAX**.

---

## 📌 Overview

This project simulates a real-world analytics workflow: designing a relational 
database, modeling it as a star schema in Power BI, writing DAX measures for 
key business KPIs, and turning the results into actionable insights.

**Dataset:** 250 customers · 31 products across 6 categories · 6,156 orders 
spanning Jan 2024 – Dec 2025.

## ⚙️ Tech Stack

| Tool | Purpose |
|---|---|
| **SQL** (MySQL/SQL Server) | Database design, joins, aggregations, validation queries |
| **Power BI** | Star schema data modeling, interactive report building |
| **DAX** | Business logic — KPIs, time intelligence, ranking measures |

## 🗂️ Project Structure
├── SQL/ → schema, data load, and 10 analysis queries
├── Data/ → sample CSVs (Customers, Products, Sales, Date)
├── PowerBI/ → DAX measures reference + step-by-step build guide
├── Documentation/ → business insights derived from the data
└── Dashboard_Preview/ → interactive HTML preview of the dashboard.

## 🚀 Features

- **Star schema data model** — one fact table (`Sales`) + three dimensions 
  (`Customers`, `Products`, `Date`) for fast, scalable querying.
- **DAX measures** — Total Sales, Total Profit, Profit Margin %, Total Orders, 
  Average Order Value (AOV), Year-over-Year (YoY) Sales Growth, and more.
- **Interactive visuals** — monthly sales trend, top-selling products, 
  category performance, regional sales, with KPI cards, slicers, and drill-downs.
- **Validated accuracy** — every DAX measure cross-checked against equivalent 
  SQL query results.

## 📈 Key Insights

- **+30.76% YoY sales growth** (2024 → 2025), consistent across every month.
- Top product drives **~17% of total revenue** — a concentration risk worth 
  monitoring.
- **West & East regions** contribute over 51% of total sales.
- **Corporate customers** have the highest average order value despite fewer orders.

Full write-up in [`Documentation/Business_Insights.md`](./Documentation/Business_Insights.md).

## 🛠️ How to Run

1. Run `SQL/01_schema.sql` and `SQL/02_load_data.sql` to set up the database.
2. Run `SQL/03_analysis_queries.sql` to reproduce the core KPIs.
3. Follow `PowerBI/PowerBI_Setup_Guide.md` to rebuild the report in Power BI Desktop.
4. Or just open `Dashboard_Preview/dashboard.html` in a browser for an instant preview.

## 📄 License

This project uses synthetically generated data for demonstration purposes.
