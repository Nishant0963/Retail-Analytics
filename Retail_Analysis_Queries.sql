use retail_analytics;
show tables;

-- PS_1
select TransactionID, count(*) from sales_Transaction
group by TransactionID 
having count(*)>1;

create table new_t as 
select distinct * from sales_Transaction;

drop table sales_Transaction;
alter table new_t rename to sales_transaction;
select * from sales_transaction;

-- PS_2

select t.TransactionID, t.Price as TransactionPrice, p.Price as InventoryPrice
from sales_transaction t
join product_inventory p on p.ProductID=t.ProductID
where t.Price <>p.Price;

update sales_transaction t
join product_inventory p on t.ProductID = p.ProductID 
set t.Price = p.Price
where p.Price<>t.Price;

select * from sales_transaction;

-- PS_3

select count(*) from customer_profiles where location is null;
update customer_profiles
set location='Unknown'
where location is null;
select * from customer_profiles;

-- PS_4

create table sale_tt as
select * from sales_transaction;
alter table sale_tt 
add column TransactionDate_Updated date;

update sale_tt
set TransactionDate_Updated = date_format(TransactionDate,'%Y-%m-%d');
drop table sales_transaction;
alter table sale_tt rename to sales_transaction;
select * from sales_transaction;

-- PS_5

select ProductID, 
sum(QuantityPurchased) as TotalUnitsSold, 
sum(QuantityPurchased*Price) as TotalSales 
from sales_transaction
group by ProductID
order by TotalSales desc;

-- PS_6

select 
CustomerID,
count(*) as NumberOfTransactions
from sales_transaction
group by CustomerID
order by NumberOfTransactions desc;

-- PS_7

select 
p.Category,
sum(t.QuantityPurchased) as TotalUnitsSold, 
sum(t.QuantityPurchased*t.Price) as TotalSales 
from sales_transaction t 
join product_inventory p on p.ProductID = t.ProductID 
group by Category
order by TotalSales desc;

-- PS_8

select 
ProductID,
sum(Price* QuantityPurchased) as TotalRevenue 
from Sales_Transaction
group by ProductID
order by TotalRevenue desc
limit 10;

-- PS_9

select 
ProductID,
sum(QuantityPurchased) as TotalUnitsSold
from Sales_transaction
group by ProductID
having TotalUnitsSold >0
order by TotalUnitsSold
limit 10;

-- PS_10

select 
date_format(TransactionDate,'%Y-%m-%d') as DATETRANS,
count(*) as Transaction_count,
sum(QuantityPurchased) as TotalUnitsSold,
round(sum(QuantityPurchased*Price),2) as TotalSales
from sales_transaction
group by DATETRANS
order by DATETRANS desc;

-- PS_11

select month,total_sales,
round(
    lag(total_sales) over(order by month ),2
) as previous_month_sales,
round(
   ( total_sales-lag(total_sales) over(order by month))/
   nullif( lag(total_sales) over(order by month ),0) * 100 ,2
)as mom_growth_percentage
from(
    select 
month(TransactionDate) as month,
round(sum(QuantityPurchased*Price),2) as total_sales
from sales_transaction
group by month(TransactionDate) 
)t
order by month;

-- PS_12

select 
CustomerID,
count(*) as NumberOfTransactions,
sum(QuantityPurchased*Price) as TotalSpent
from sales_transaction
group by CustomerID
having count(*)>10 and sum(QuantityPurchased*Price) >1000 
order by TotalSpent desc;


-- PS_13

select 
CustomerID,
count(*) as NumberOfTransactions,
sum(QuantityPurchased*Price) as TotalSpent
from sales_transaction
group by CustomerID
having count(*) <=2 
order by NumberOfTransactions, TotalSpent desc;


-- PS_14

select 
CustomerID,
ProductID,
count(*) as TimesPurchased
from Sales_transaction
group by CustomerID,ProductID
having count(*)>1
order by TimesPurchased desc;

-- PS_15

select 
CustomerID,
min(str_to_date(Transactiondate,'%Y-%m-%d')) as FirstPurchase,
max(str_to_date(Transactiondate,'%Y-%m-%d')) as LastPurchase,
datediff(max(str_to_date(Transactiondate,'%Y-%m-%d')),
min(str_to_date(Transactiondate,'%Y-%m-%d')))
as DaysBetweenPurchases
from Sales_transaction 
group by CustomerID
having DaysBetweenPurchases>0
order by DaysBetweenPurchases desc;


-- PS_16

create table customer_transaction as 
select 
c.CustomerID,
sum(s.QuantityPurchased) as TotalQuantity,
case 
when sum(s.QuantityPurchased) between 1 and 10 then 'Low'
when sum(s.QuantityPurchased) between 11 and 30 then 'Med'
else 'High'
end as CustomerSegment 
from customer_profiles c 
join sales_transaction s on c.CustomerID=s.CustomerID
group by c.CustomerID;

select CustomerSegment,
count(*) 
from customer_transaction
group by CustomerSegment;