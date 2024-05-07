-- Food Panda case study

--1. Find customers who have never ordered
--2. Average Price/dish
--3. Find the top restaurant in terms of the number of orders for a given month
--4. restaurants with monthly sales greater than x for 
--5. Show all orders with order details for a particular customer in a particular date range
--6. Find restaurants with max repeated customers 
--7. Month over month revenue growth of swiggy
--8. Customer - favorite food

--Homework
--Find the most loyal customers for all restaurant
--Month over month revenue growth of a restaurant
--Most Paired Products








-- 1. Find customers who have never ordered

select name from users where user_id not in (select user_id from orders group by user_id)


-- 2. Average Price/dish

select f.f_name, avg(price) as Average_price 
from menu m join food f 
on m.f_id = f.f_id 
group by f.f_name, f.f_id
order by f.f_id


-- 3. Find the top restaurant in terms of the number of orders for a given month

select FORMAT(date, 'MMMM'),r.r_name, count(o.r_id) total_order

from orders o join restaurants r 

on o.r_id = r.r_id

where FORMAT(date, 'MMMM') = 'July'

group by o.r_id , FORMAT(date, 'MMMM'), r.r_name

order by total_order desc

offset 0 row fetch next 1 row only



-- 4. restaurants with monthly sales greater than x for (x=800)

select r.r_name, FORMAT(o.date,'MMMM') as months, sum(o.amount) as total
from restaurants r join orders o on r.r_id = o.r_id
group by r.r_name, FORMAT(o.date,'MMMM')
having sum(o.amount) > 800


-- 5. Show all orders with order details for a particular customer in a particular date range

select name,f.f_name, r_name, sum(amount) total_cost, cast(o.Date as Date) as Date
from users u
join orders o on u.user_id = o.user_id 
join order_details od on od.order_id = o.order_id
join food f on od.f_id = f.f_id
join restaurants r on o.r_id = r.r_id
where name = 'Nitish' and (o.date between '2022-07-1' and '2022-07-28')
group by name, f.f_name,r.r_name, o.Date




-- 6. Find restaurants with max repeated customers

with cte as (
	Select r_name, o.user_id, count(user_id) visits
	from restaurants r join orders o on r.r_id = o.r_id
	group by r_name,o.user_id
	having count(user_id) > 1
	--order by repeated_customers desc
)
select r_name, count(visits) as total_repeated_customers
from cte
group by r_name
order by total_repeated_customers desc
offset 0 row fetch next 1 row only



-- 2nd way
select r_name, count(visits) as total_repeated_customers
from 
(
	Select r_name, o.user_id, count(user_id) visits
	from restaurants r join orders o on r.r_id = o.r_id
	group by r_name,o.user_id
	having count(user_id) > 1
) as temp
group by r_name
order by total_repeated_customers desc
offset 0 row fetch next 1 row only



-- 7. Month over month revenue growth of swiggy

select Format(o.date, 'MMMM') 'MonthName', sum(o.amount) as TotalRevenue
from orders o
group by Format(date, 'MMMM')
order by 'MonthName' desc


-- 8. Customer -> favorite food

with cte as(
Select u.name, f.f_name, count(f.f_name) no_of_ordered
from users u 
join orders o on u.user_id = o.user_id 
join order_details od on o.order_id = od.order_id 
join food f on od.f_id = f.f_id
group by u.name, f.f_name
)
select name, f_name
from cte c1
where no_of_ordered in (select max(no_of_ordered) from cte c2 where c2.name = c1.name)   --max category-wise



-- 9. Find the most loyal customers for all restaurant

select r.r_name,u.name,  count(o.user_id) as Visits
from users u join restaurants r on u.user_id = r.r_id join orders o on u.user_id = o.user_id
group by u.name, r.r_name


-- 10. Month over month revenue growth of a restaurant

Select r.r_name,format(o.date,'MMMM') Months, sum(o.amount) revenue
from restaurants r join orders o on r.r_id = o.r_id
where r.r_name = 'China Town'
group by r.r_name,format(o.date,'MMMM')


-- 11. Most Paired Products

WITH nfood AS (

    SELECT od.order_id, f.f_name, ROW_NUMBER() over(order by od.order_id) as row_no
    FROM order_details od
    JOIN food f ON od.f_id = f.f_id

)
SELECT Top 2 f1.f_name +' & '+ f2.f_name as PairedFood, count(*) freq
from nfood f1 
join nfood f2 on f1.order_id = f2.order_id
where f1.row_no < f2.row_no
group by f1.f_name +' & '+ f2.f_name
order by freq desc