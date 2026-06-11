use RetailData;

--Display all details from each tables 

select * from brands;
select * from categories;
select * from customers;
select * from orderItems;
select * from orders;
select * from products;
select * from staffs;
select * from stocks;
select * from stores;

--Retreive order ID, product ID, and list price for items priced at or above 2500
select order_id, product_id, list_price
from orderItems
where list_price >= 2500;

-- Retrieve products from brand ID 9 with a list price of 500 or higher
select product_name, brand_id, list_price
from products
where brand_id = 9 and list_price >=500;

-- Show products that either belong to brand ID 1 or have a list price below 200
select product_name, brand_id, list_price
from products
where brand_id = 1 or list_price < 200;

-- List order items with list prices between 500 and 1000
select order_id, product_id, list_price
from orderItems
where list_price between 500 and 1000;

-- Find customers whose first name ends with 'sha'
select customer_id, first_name, last_name, state
from customers
where first_name like '%sha';

-- Find staff members whose last name starts with 'da'
select staff_id, first_name, last_name, store_id
from staffs
where last_name like 'da%'

-- Identify customers whose first name contains 'el'
select customer_id, first_name, last_name, state
from customers
where first_name like '%el%';

-- Display list price of all products in ascending order
select *
from products
order by list_price asc;

-- Sort list price in descending order
select order_id, product_id, quantity, list_price
from orderItems
order by list_price desc;

-- Count total number of products available
 select COUNT(product_name)  AS total_no_of_products 
from products;


-- Calculate the average list price of all products
select avg(list_price) as average_list_price
from products;

-- Calculate and round the average product list price to two decimal places
select round(avg(list_price), 2) as average_list_price
from products;

-- Find the highest product list price
select max(list_price) as highest_price
from products;

-- Find the lowest product list price
select min(list_price) as lowest_price
from products;

-- Total number of products per brand
select brand_id, COUNT(*) as product_count
from products
group by brand_id;

 -- Count no. of customers per state using group by
select state, COUNT(customer_ID) as total_customers
from customers
group by state;

-- Determine avg list price and product count per brand id
select brand_id, COUNT(*) as product_count, round(AVG(list_price),2) as avg_list_price_per_brand_id
from products
group by brand_id;

-- Determine product count and avg list price per brand_id that have avg list price greater than 500
select brand_id, COUNT(*) as product_count, round(AVG(list_price),2) as avg_list_price_per_brand_id
from products
group by brand_id
having avg(list_price) > 500;

-- Only show brands with more than 10 products
select brand_id, COUNT(*) as product_count
from products
group by brand_id
having COUNT(*) > 10;
 
 -- CUSTOMER GEOGRAPHIC DEMOGRAPHICS

 -- Show all unique customer states
select distinct state
from customers;

-- Count how many unique states customers belong to
select count(distinct state)
from customers;


 -- SALES OVERVIEW

-- calculate total sales
select round(sum(quantity * list_price),2) as total_sales
from orderItems;

-- Calculate total number of orders
select count(order_id) as total_orders
from orders;

-- Calculate avg order value
select round(sum(quantity * list_price) / count(distinct order_id), 2) as average_order_value
from
    orderItems;

-- Show which store is performing best in terms of orders
select store_id, count(order_id) as total_orders_handled
from orders
group by store_id
order by total_orders_handled desc;
-- Store_id 2 is performing well as compared to others as it handled a total of 1093 orders

--EMPLOYEE RELATED QUERY

--Determine employee performance as to rank which staff member is handling most orders
select staff_id, count(order_id) as orders_processed
from orders
group by staff_id
order by orders_processed desc;
-- Employee with staff_id 6 and 7 performed best with 553 and 540 orders respectively. Whereas, employee with staff_id 9 just got 86 orders processed.

-- PRODUCT RELATED QUERIES

-- List down top 5 best-performing products
select top 5
p.product_name, sum(oi.quantity) as total_units_sold,
round(sum(oi.quantity * oi.list_price), 2) as total_revenue
from orderItems oi
inner join products p on oi.product_id = p.product_id
group by p.product_name
order by total_revenue desc;

-- find products that never got sold to identify dead stock problem
select p.product_id, p.product_name
from products p
left join orderItems oi on p.product_id = oi.product_id
where oi.order_id is null;
--Turns out total of 14 items never got sold