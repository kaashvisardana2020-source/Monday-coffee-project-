# Monday Coffee Expansion & Retail Analytics (MySQL)

## Objective
The goal of this project is to analyze the sales data of Monday Coffee, a company that has been selling its products online since January 2023, and to recommend the top three major cities in India for opening new coffee shop locations based on consumer demand and sales performance.

---

## 🏗️ Relational Schema & Architecture
The analysis runs on a normalized relational database schema in **MySQL (v8.0+)** consisting of 4 core tables:

* `city`: City-level population metrics and average commercial rent estimates.
* `customers`: Demographic data and city assignments for registered users.
* `products`: Coffee SKU catalog, prices, and product mapping.
* `sales`: Detailed transaction records containing sale dates and total purchase amounts.

Key Questions
1 Coffee Consumers Count
How many people in each city are estimated to consume coffee, given that 25% of the population does?

2 Total Revenue from Coffee Sales
What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

3 Sales Count for Each Product
How many units of each coffee product have been sold?

4 Average Sales Amount per City
What is the average sales amount per customer in each city?

5 City Population and Coffee Consumers
Provide a list of cities along with their populations and estimated coffee consumers.

6 Top Selling Products by City
What are the top 3 selling products in each city based on sales volume?

7 Customer Segmentation by City
How many unique customers are there in each city who have purchased coffee products?

8 Average Sale vs Rent
Find each city and their average sale per customer and avg rent per customer.

9 Monthly Sales Growth
Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).

10 Market Potential Analysis
Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer.

🛠️ Advanced SQL Concepts Applied
Multi-Table JOINs: Querying data across sales, customers, city, and products.

Window Functions: Utilizing DENSE_RANK() OVER (PARTITION BY ...) for top-selling products and LAG() OVER (...) for MoM growth rate calculation.

Common Table Expressions (CTEs): Structuring multi-step aggregated queries for clean readability.

Aggregations & Ratios: Calculating Average Order Value (AOV), sales-to-rent ratios, and consumer market penetration.

Recommendations
After analyzing the data, the recommended top three cities for new store openings are:

🥇 1. Pune
Average rent per customer is very low.

Highest total revenue generated.

Average sales per customer is also high.

🥈 2. Delhi
Highest estimated coffee consumers at 7.7 million.

Highest total number of customers (68 active buyers).

Average rent per customer is ₹330 (under the ₹500 threshold).

🥉 3. Jaipur
Highest number of active customers (69 buyers).

Average rent per customer is very low at ₹156.

Average sales per customer is high at ₹11.6k.
