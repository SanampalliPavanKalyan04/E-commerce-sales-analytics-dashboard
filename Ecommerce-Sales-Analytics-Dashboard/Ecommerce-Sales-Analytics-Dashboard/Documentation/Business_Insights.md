# Business Insights — E-commerce Sales Analytics

*Derived from `/SQL/03_analysis_queries.sql` run against the dataset in
`/Data`, and cross-checked against the Power BI DAX measures.*

## 1. Headline Numbers (FY2024–FY2025)

| KPI | Value |
|---|---|
| Total Sales | ₹3,60,84,468.62 (~₹3.61 Cr) |
| Total Profit | ₹1,21,78,041.95 (~₹1.22 Cr) |
| Profit Margin | 33.75% |
| Total Orders | 6,156 |
| Average Order Value (AOV) | ₹5,861.67 |
| YoY Sales Growth (2024 → 2025) | **+30.76%** |

**Insight:** Revenue grew from ₹1.56 Cr in 2024 to ₹2.04 Cr in 2025, a strong
30.76% increase. Combined with a healthy 33.75% overall profit margin, the
business is scaling revenue without eroding profitability — the underlying
cost structure and pricing are both holding up.

## 2. Monthly Sales Trend

- Sales dip every **February** in both years (₹8.6L in 2024, ₹12.4L in 2025)
  — a predictable seasonal low likely worth a targeted promotion.
- **August–December** is consistently the strongest stretch each year,
  peaking at ₹20.5L in August 2025 — aligning with festive/holiday shopping
  season. Inventory and marketing spend should be front-loaded into Q3 to
  capture this.
- Month-over-month, 2025 outperformed the equivalent 2024 month in **every
  single month**, confirming the growth is broad-based rather than a one-off
  spike.

## 3. Top-Selling Products

| Rank | Product | Category | Revenue |
|---|---|---|---|
| 1 | Air Fryer | Home & Kitchen | ₹60.2L |
| 2 | Vacuum Cleaner | Home & Kitchen | ₹36.6L |
| 3 | Wireless Earbuds | Electronics | ₹32.8L |
| 4 | Running Shoes | Clothing | ₹26.8L |
| 5 | Desk Organizer | Books & Stationery | ₹25.0L |

**Insight:** The **Air Fryer** alone drives ~16.7% of total company revenue —
a single-product concentration risk worth flagging to leadership (stock-outs
or supplier issues on this SKU would materially hit revenue). It's a strong
candidate for bundling and cross-sell campaigns.

## 4. Category Performance

| Category | Sales | Margin % |
|---|---|---|
| Home & Kitchen | ₹1.06 Cr | 29.7% |
| Electronics | ₹91.5L | 34.7% |
| Clothing | ₹50.9L | 35.5% |
| Beauty & Personal Care | ₹47.8L | 32.9% |
| Sports & Fitness | ₹34.8L | 32.7% |
| Books & Stationery | ₹29.5L | **45.2%** |

**Insight:** Home & Kitchen is the #1 category by revenue but has the
**second-lowest margin** — it's a volume play, not a margin play. Books &
Stationery is small in revenue but by far the most profitable *per rupee of
sales* (45.2% margin); worth testing whether it can be scaled with more
marketing spend.

## 5. Regional Performance

| Region | Sales | Profit | Orders |
|---|---|---|---|
| West | ₹97.8L | ₹33.4L | 1,634 |
| East | ₹88.2L | ₹29.7L | 1,472 |
| North | ₹64.8L | ₹21.2L | 1,174 |
| South | ₹56.8L | ₹19.1L | 942 |
| Central | ₹53.3L | ₹18.3L | 934 |

**Insight:** **West** and **East** together contribute over 51% of total
revenue. **Central** and **South** are the smallest regions both in orders
and revenue — good candidates for a regional marketing push to close the gap,
or a deeper investigation into whether it's a demand issue or a
distribution/logistics gap.

## 6. Customer Segments

| Segment | Sales | Orders | AOV |
|---|---|---|---|
| Consumer | ₹2.15 Cr | 3,692 | ₹5,836.79 |
| Corporate | ₹88.3L | 1,459 | **₹6,050.98** |
| Small Business | ₹57.1L | 1,005 | ₹5,678.29 |

**Insight:** Corporate customers order less frequently but spend the most
per order (highest AOV). A B2B-focused upsell or bulk-discount program could
be disproportionately effective given this segment's willingness to spend
more per transaction.

## 7. Top Customers

The top 5 customers by lifetime spend (Suresh Verma, Divya Rao, Ananya
Reddy, Vivaan Iyer, Vivaan Verma) each generated ₹4.3L–₹5.6L in revenue.
Recommend a loyalty/VIP tier for the top 1–2% of customers by spend to
protect this high-value relationship.

## 8. Products Needing Attention (Margin < 20%)

| Product | Category | Margin % |
|---|---|---|
| Face Serum | Beauty & Personal Care | 13.0% |
| Formal Shirt | Clothing | 17.6% |
| Wireless Earbuds | Electronics | 19.3% |
| Men's T-Shirt | Clothing | 19.8% |

**Insight:** Wireless Earbuds is simultaneously a **top-3 revenue driver**
and a **low-margin product** — the classic "high volume, thin margin" SKU.
A small price increase (2–3%) or supplier renegotiation here would have an
outsized impact on total company profit given its sales volume.

## Summary of Recommended Actions

1. Protect and expand Air Fryer supply chain — it's a single point of
   revenue concentration.
2. Re-price or renegotiate cost on Wireless Earbuds to lift its margin
   without hurting its volume.
3. Run a February promotion to smooth out the seasonal dip.
4. Invest marketing spend into Central and South regions to close the gap
   with West/East.
5. Build a Corporate-segment offer (bulk pricing/loyalty) given its higher
   AOV.
6. Launch a VIP program for top-decile customers by spend.
