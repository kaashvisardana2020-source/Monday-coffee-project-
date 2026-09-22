#Monday coffee --data analysis

select * from city;
select * from products;
select * from  customers;
select * from sales;

#Q1 
#COFFEE CONSUMER COUNT
# How many people in each city are estimated to consume coffee ,given that 25% of the population does?

SELECT 
population * 0.25 as quarter_count , 
city_name
from city 
group by city_name ,  quarter_count 
order by quarter_count desc ;

# Q2
# Total Revenue from Coffee Sales
# What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?


SELECT cy.city_id, cy.city_name,sum(total) as total_revenue 
from sales s
join customers c 
on s.customer_id=c.customer_id
join city cy
on c.city_id=cy.city_id
where sale_date >= '2023-10-01' and sale_date <= '2023-12-31'
group by cy.city_id,cy.city_name
order by total_revenue desc;



#Q.3
# Sales Count for Each Product
# How many units of each coffee product have been sold?

select p.product_id,p.product_name , count(s.product_id) as no_of_units_sold
from products p
left join sales s
on p.product_id=s.product_id
group by  p.product_id ,p.product_name 
order by no_of_units_sold desc;

#Q.4
#Average Sales Amount per City
#What is the average sales amount per customer in each city?

select cy.city_name , 
sum(s.total) as total_revenue ,
count(distinct c.customer_id),
round(sum(s.total) / count(distinct c.customer_id) ,2  ) as average_sales_amt
from sales s
join customers c 
on s.customer_id= c.customer_id
join city cy 
on cy.city_id = c.city_id
group by cy.city_name
order by average_sales_amt desc;


# Q.5
# City Population and Coffee Consumers (25%)
# Provide a list of cities along with their populations and estimated coffee consumers.
# return city_name, total current cx, estimated coffee consumers (25%)

select c.city_name,c.population, count(distinct cs.customer_id) as total_cx_customers , 
round(c.population*0.25/1000000,3) as estimated_coffee_consumers_in_millions
from city c
join customers cs
on c.city_id =cs.city_id
join sales s
on s.customer_id = cs.customer_id
group by c.city_name,c.population
order by count(cs.customer_id) desc;

#Q6
# Top Selling Products by City
# What are the top 3 selling products in each city based on sales volume?

select *
from 
(
select c.city_name, p.product_name , count(s.sale_id) as total_orders ,
dense_rank() over(partition by c.city_name order by count( s.sale_id) desc) as _rank
from city c 
join customers cs 
on cs.city_id  = c.city_id
join sales s 
on s.customer_id= cs.customer_id
join products p 
on p.product_id = s.product_id
group by c.city_name , p.product_name
order by c.city_name, total_orders desc
) as t1
where _rank <= 3;

#Q.7
#Customer Segmentation by City
# How many unique customers are there in each city who have purchased coffee products?

select c.city_name, count(distinct cs.customer_id) as unique_cs
from customers cs
join city c 
on c.city_id = cs.city_id
join sales s 
on s.customer_id =cs.customer_id
join products p
on p.product_id = s.prodouct_id
where p.product_id between 1 and 14
group by c.city_name;

 #Q.8
#Average Sale vs Rent
# Find each city and their average sale per customer and avg rent per customer

select c.city_name , round(sum(total)/count(distinct s.customer_id),2) as averge_sales_pc , round((c.estimated_rent)/count(distinct s.customer_id),2) as average_rent_pc
from city c
join customers cs 
on cs.city_id = c.city_id
join sales s
on s.customer_id = cs.customer_id
group by c.city_name, c.estimated_rent;

#Q.9
#Monthly Sales Growth
# Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
#by each city

with monthly_sales as (select sum(total) as total_sales , month(s.sale_date) as sales_month , year(s.sale_date) as sales_year ,c.city_name as city_name
from sales s
join customers cs
on cs.customer_id = s.customer_id
join city c
on c.city_id=cs.city_id
group by month(s.sale_date), year(s.sale_date) , c.city_name
order by sales_month)

select  sales_month , sales_year  , city_name , total_sales ,
lag(total_sales) over (partition by city_name order by sales_year asc,sales_month asc) as previous_month_sales,
round((total_sales-lag(total_sales) over (partition by city_name order by sales_year asc,sales_month asc ))
 /lag(total_sales) over (partition by city_name order by sales_year asc,sales_month asc)*100,2) as growth_rate_percentage
from monthly_sales;

#.10
#Market Potential Analysis
#Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer
select c.city_name ,  sum(s.total) as total_sales , c.estimated_rent , count(distinct cs.customer_name) as total_cx ,(c.population*0.25) as estimated_coffee_consumers ,
(estimated_rent/ count(distinct cs.customer_name)) as avg_rent_pc,
 (sum(s.total)/count(distinct cs.customer_name)) as avg_sales_pc
from city c
join customers cs
on cs.city_id= c.city_id
join sales s
on s.customer_id =cs.customer_id
group by c.city_name , c.estimated_rent ,(c.population*0.25)
order by total_sales desc
limit 3;

/*
Recomendation
City 1: Pune
	1.Average rent per customer is very low.
	2.Highest total revenue.
	3.Average sales per customer is also high.

City 2: Delhi
	1.Highest estimated coffee consumers at 7.7 million.
	2.Highest total number of customers, which is 68.
	3.Average rent per customer is 330 (still under 500).

City 3: Jaipur
	1.Highest number of customers, which is 69.
	2.Average rent per customer is very low at 156.
	3.Average sales per customer is better at 11.6k.
