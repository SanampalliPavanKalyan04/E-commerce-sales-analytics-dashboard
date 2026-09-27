# Power BI Build Guide — Step by Step

This guide walks through rebuilding the dashboard in Power BI Desktop from the
files in this project (`/Data/*.csv` or the `/SQL` database).

## 1. Get Data & Build the Star Schema

1. Open **Power BI Desktop → Get Data → Text/CSV** (or **SQL Server / MySQL
   database** if you loaded the data using the scripts in `/SQL`).
2. Import all four tables: `Customers`, `Products`, `Date_Dimension`, `Sales`.
3. Go to **Model view** and create these relationships (all **one-to-many**,
   single direction, from dimension → fact):
   - `Customers[CustomerID]` → `Sales[CustomerID]`
   - `Products[ProductID]` → `Sales[ProductID]`
   - `Date_Dimension[DateKeyInt]` → `Sales[DateKeyInt]`
4. Arrange the tables visually with `Sales` in the middle and the three
   dimensions around it — this is the **star schema**.
5. Select `Date_Dimension[Date]` → **Modeling ribbon → Mark as Date Table**.

## 2. Add DAX Measures

1. **Modeling → New Table** → name it `_Measures` → formula: `_Measures = { 1 }`.
2. Hide the dummy column, keep the table pinned to the top of the Fields pane.
3. Copy in every measure from `DAX_Measures.md` (`New Measure` for each one).

## 3. Build the Report Pages

**Page 1 — Executive Overview**
- KPI cards across the top: `Total Sales`, `Total Profit`, `Profit Margin %`,
  `Total Orders`, `Average Order Value (AOV)`, `YoY Sales Growth %`.
- Line chart: `Date_Dimension[MonthYear]` (X-axis) vs `Total Sales` and
  `Total Profit` (Y-axis) — the monthly sales trend.
- Clustered bar chart: `Products[Category]` vs `Total Sales`, sorted
  descending — category performance.
- Map or filled map: `Customers[Region]` vs `Total Sales` — regional sales.
- Slicers: `Date_Dimension[Year]`, `Products[Category]`, `Customers[Region]`.

**Page 2 — Products**
- Bar chart: Top 10 products by `Total Sales` (use `Product Sales Rank`
  measure to filter Top N via a visual-level filter, `Top N = 10`).
- Table: `ProductName`, `Category`, `Total Units Sold`, `Total Sales`,
  `Total Profit`, `Profit Margin %`.
- Scatter chart: `Total Sales` (X) vs `Profit Margin %` (Y), bubble size =
  `Total Units Sold` — quickly spots high-revenue/low-margin products.

**Page 3 — Customers & Regions**
- Bar chart: Top 10 customers by `Total Sales`.
- Donut chart: `Customers[Segment]` vs `Total Sales`.
- Filled map / bar chart: `Region` vs `Total Sales`, `Total Profit`.
- Table with drill-down: `Region → State → CustomerName`.

**Page 4 — Time Intelligence**
- Column chart: `Year` vs `Total Sales`, with data labels for `YoY Sales
  Growth %`.
- Line chart: `Sales MTD`, `Sales QTD`, `Sales YTD` over the calendar.

## 4. Interactivity

- **Slicers**: Year, Quarter, Region, Category, Segment (sync slicers across
  pages via *View → Sync Slicers* where relevant).
- **Drill-down**: enable drill-down on the Region → State hierarchy and the
  Date hierarchy (Year → Quarter → Month → Day) — click the drill-down arrow
  on each visual's header.
- **Cross-filtering**: leave default — clicking any bar/segment filters the
  rest of the page.
- **Tooltips**: add a tooltip page showing `Total Sales`, `Total Profit`, and
  `Profit Margin %` for whatever is hovered.

## 5. Formatting Checklist

- Consistent color theme (View → Themes) — one accent color for Sales, a
  second for Profit.
- Number formatting: currency for money measures, 1 decimal % for margins.
- Page-level filters: exclude test/void orders if any exist.
- Add a title, a last-refreshed date card (`= NOW()` measure), and your name /
  project title in the footer.

## 6. Publish & Validate

1. **File → Publish → Power BI Service** (optional, if you have a workspace).
2. Re-run `/SQL/03_analysis_queries.sql` and compare the numbers to your KPI
   cards — they should match exactly. This is the validation step referenced
   in the project summary.
