create table Books (
Book_ID serial primary key,
Title varchar(100),
Author varchar(50),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int 
);

select * from Books;


create table customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100), 
Phone varchar(15),
City varchar(50),
Country varchar(50)
);

alter table customers
alter column country type varchar(100);

select * from customers;


Drop table if exists orders;

create table orders(
Order_ID serial primary key,
Customer_ID int REFERENCES customers(Customer_Id),
Book_ID int REFERENCES Books(Book_ID),
Order_Date date,
Quantity int,
Total_Amount numeric(10,2)
);

select * from orders;


--BASIC QUERIES
--q1-Retrieve all books in the 'Fiction' genre:
select * from books where genre = 'Fiction';

--q2 find books published after the year 1950;
select title , published_year
from books where Published_Year>1950;

--q3 List all the customers from canada;
select name,city,country
from customers where country='Canada';

--q4 Show orders placed in november 2023;
select quantity,order_date
from orders where order_date between '2023-11-01' And '2023-11-30';


--q5 Retrieve the total stock of books available: 
select sum(stock) as total_stock
from books; 

--q6 find the details of the most expensive book:
select *
from books
order by price desc
limit 1; 

--q7 show all customers who ordered more than 1 quantity of a book
select o.order_id,o.customer_id,c.Name,o.quantity
from orders o
left join
customers c
on o.customer_id =c.customer_id
where o.quantity>1;

--q8 Retrieve all orders where the total amount exceeds $20:
select order_id,total_amount 
from orders
where total_amount>20;

--q9 list all genres available in the books table:
select distinct genre
from books;

--q10 Find the book with the lowest stock:
select title,stock
from books order by stock asc
limit 1; 

--q11 Calculate the total revenue generated from all orders;
select sum(total_amount) as total_revenue
from orders;

--Advanced Ques

--1. Retrieve the total number of books sold for each genre

select b.genre, sum(o.quantity)as total_books_sold
from orders o
join
books b
on o.book_id=b.book_id
Group by b.genre;

--2: find the average price of books in the 'Fantasy' genre:
select avg(price) as avg_price_of_fantasy_books 
from books
where genre='Fantasy';

--3 List customers who have placed at least 2 orders;
select o.customer_id, c.name,count(o.order_id)
from orders o
join
customers c
on o.customer_id=c.customer_id
group by c.name, o.customer_id
having count(order_id)>=2;

--4 find the most frequently ordered book;
select book_id , count(order_id) as order_count
from orders
group by book_id
order by order_count desc
limit 1;

--6 Retrieve the total quantity of books sold by each author:

select b.author,sum(o.quantity) as total_quantity
from orders o
join books b
on o.book_id=b.book_id
group by b.author;

--7 List the cities where customers who spent over $30 are located:
 select distinct c.city, o.total_amount
 from orders o
 join customers c 
 ON o.customer_id = c.customer_id
 where o.total_amount>300;

--8 Find the customer who spent the most on orders;
select c.customer_id, c.name, sum(o.total_amount) as Total_spent
from orders o 
join customers c 
ON o.customer_id = c.customer_id
Group by c.customer_id, c.name
order by total_spent desc limit 1;
