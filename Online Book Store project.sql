-- Create Database
CREATE DATABASE OnlineBookstore;
use OnlineBookstore;
-- Import tables from Csv file
-- Add constraints in tables

select * from books; 
Alter table books
Add constraint primary key (Book_ID);

select * from customers;
Alter table Customers
Add constraint primary key (Customer_ID);

Alter table Customers
Add constraint pqr unique(email);


Select * from orders;
Alter table orders
Add constraint primary key(order_id);

Alter table orders
Add constraint primary key(order_id);

Alter table orders
Add constraint xyz foreign key(Customer_ID) references Customers(Customer_ID);

Alter table orders
Add constraint abc foreign key(Book_ID) references Books(Book_ID);
desc orders;


-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year>1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';


SELECT * FROM Orders 
WHERE monthname(order_date)="November";


-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;


-- 6) Find the details of the most expensive book:
select * from books where price=(select max(price) from books);

SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;



-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;



-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;


-- 10) Find the book with the lowest stock:
select * from books where stock=(select min(stock) from books) limit 1;

SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;

-- Advance Questions : 
select * from customers;
select * from books;
select * from orders;

-- 1) Retrieve the total number of books sold for each genre:
select b.genre,Sum(o.quantity) as total_quantity from books as b join orders as o on b.Book_ID=o.Book_ID group by b.genre;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold																																				
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) from books where book_id in (select book_id from books where genre="fantasy");

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:
select customer_id, count(order_ID)from orders group by customer_id having count(order_id)>=2 order by customer_id asc;

SELECT o.customer_id, c.name,COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

select * from customers;
select * from orders;
select book_id,count(book_id) from orders group by book_id having count(book_id)>3 order by count(book_id) desc;
-- 4) Find the most frequently ordered book:
select book_id,count(book_id) from orders group by book_id order by count(book_id) desc limit 1;

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select title,price from books where genre="Fantasy" order by price desc limit 3;

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author,sum(o.quantity) as total_sales from books as b join orders as o on b.book_id=o.book_id group by b.author;
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city,o.total_amount from customers as c join orders as o on c.customer_id=o.order_id where o.total_amount>30;
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.name,sum(o.total_amount) as total_spending from customers as c join orders as o on c.customer_id=o.customer_id group by c.name order by total_spending desc limit 1;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

select * from orders;
select * from books;
select * from customers;

-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;