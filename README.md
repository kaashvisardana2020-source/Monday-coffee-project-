# Monday Coffee Expansion & Retail Analytics (MySQL)

![Project Banner](assets/banner.png)

## Objective
The goal of this project is to analyze the sales data of Monday Coffee, a company that has been selling its products online since January 2023, and to recommend the top three major cities in India for opening new coffee shop locations based on consumer demand and sales performance.

---

## 🏗️ Relational Schema & Architecture
The analysis runs on a normalized relational database schema in **MySQL (v8.0+)** consisting of 4 core tables:

* `city`: City-level population metrics and average commercial rent estimates.
* `customers`: Demographic data and city assignments for registered users.
* `products`: Coffee SKU catalog, prices, and product mapping.
* `sales`: Detailed transaction records containing sale dates and total purchase amounts.

```text
       ┌──────────────┐             ┌──────────────┐
       │     city     │             │  customers   │
       ├──────────────┤             ├──────────────┤
       │ city_id (PK) │─── 1:N ───► │ customer_id  │
       │ city_name    │             │ city_id (FK) │
       │ population   │             └──────┬───────┘
       │ est_rent     │                    │
       └──────────────┘                    │ 1:N
                                           ▼
       ┌──────────────┐             ┌──────────────┐
       │   products   │             │    sales     │
       ├──────────────┤             ├──────────────┤
       │ product_id   │─── 1:N ───► │ sale_id (PK) │
       │ product_name │             │ customer_id  │
       │ price        │             │ product_id   │
       └──────────────┘             │ total        │
                                    └──────────────┘
