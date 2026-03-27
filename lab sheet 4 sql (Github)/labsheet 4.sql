CREATE DATABASE Citybooks;
USE Citybooks;
-- Create Book table 
CREATE TABLE Book ( 
BookID INT PRIMARY KEY, 
Title VARCHAR(100) NOT NULL, 
Author VARCHAR(60), 
Category VARCHAR(40), 
Price DECIMAL(7,2) CHECK (Price > 0) 
);
 -- Create Customer table 
CREATE TABLE Customer ( 
CustomerID INT PRIMARY KEY, 
Name VARCHAR(60) NOT NULL, 
City VARCHAR(40) 
); 
 
-- Create OrderHeader table 
CREATE TABLE OrderHeader ( 
OrderID INT PRIMARY KEY, 
CustomerID INT, 
OrderDate DATE, 
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
); 
-- Create OrderItem table 
CREATE TABLE OrderItem ( 
OrderID INT, 
BookID INT, 
Quantity INT CHECK (Quantity > 0), 
PRIMARY KEY (OrderID, BookID), 
FOREIGN KEY (OrderID) REFERENCES OrderHeader(OrderID), 
FOREIGN KEY (BookID) REFERENCES Book(BookID) 
);
-- Insert Books 
INSERT INTO Book VALUES 
(1, 'Introduction to Algorithms', 'Thomas Cormen', 'Technology', 4500.00), 
(2, 'Clean Code', 'Robert Martin', 'Technology', 3200.00), 
(3, 'The Alchemist', 'Paulo Coelho', 'Fiction', 1800.00), 
(4, 'Sapiens', 'Yuval Harari', 'History', 2500.00), 
(5, 'Business Strategy', 'Michael Porter', 'Business', 3800.00), 
(6, 'The Lean Startup', 'Eric Ries', 'Business', 2900.00), 
(7, '1984', 'George Orwell', 'Fiction', 1500.00); 
-- Insert Customers 
INSERT INTO Customer VALUES 
(101, 'Kasun Perera', 'Colombo'), 
(102, 'Nimali Fernando', 'Kandy'), 
(103, 'Rajitha Silva', 'Colombo'), 
(104, 'Dilini Jayawardena', 'Galle'); 
-- Insert Orders 
INSERT INTO OrderHeader VALUES 
(501, 101, '2025-01-15'), 
(502, 102, '2025-01-18'), 
(503, 101, '2025-02-10'), 
(504, 103, '2025-02-14'); 

-- Insert Order Items 
INSERT INTO OrderItem VALUES 
(501, 1, 1), 
(501, 3, 2), 
(502, 2, 1), 
(502, 5, 1), 
(503, 4, 1), 
(503, 6, 2), 
(504, 1, 1), 
(504, 2, 1), 
(504, 7, 3); 

-- Part 2
-- Q1
SELECT bookid , title , author 
FROM Book;
-- Q2
SELECT * FROM Book WHERE Category = 'Technology';

-- Q3
SELECT * FROM Customer WHERE City = 'Colombo';
-- Q4
SELECT * FROM OrderHeader WHERE Orderdate > '2025-01-01'
ORDER BY Orderdate ASC ;
-- Q5
SELECT * FROM Book
WHERE Price < 2000.00;

-- Part 3
-- Q1
SELECT COUNT(*)  FROM Book;
-- Q2
SELECT AVG(price) AS Avg_price FROM Book;
-- Q3
SELECT MAX(Price) AS Max_price , MIN(Price) AS Min_price 
FROM Book;
-- Q4
SELECT Category , COUNT(*) FROM Book
GROUP BY Category;
-- Q5 
SELECT Sum(Quantity) FROM OrderItem;

-- Part 4;
-- Q1
SELECT orderid , customerid , orderdate 
FROM orderheader;
-- Q2
SELECT orderid , title , quantity 
FROM Orderitem o JOIN Book b 
ON o.bookid = b.bookid;
-- Q3
SELECT Name , title ,quantity 
FROM orderheader o JOIN customer c 
ON o.customerid = c.customerid
JOIN orderitem oi ON o.orderid = oi.orderid
JOIN book b ON oi.bookid = b.bookid
WHERE name = 'Kasun Perera';
-- Q4
SELECT c.name ,c.city , b.title , oi.quantity, o.orderdate
FROM customer c JOIN orderheader o
ON c.customerid = o.customerid
JOIN orderitem oi ON o.orderid = oi.orderid
JOIN book b ON b.bookid = oi.bookid;
-- Q5
SELECT b.title , sum(quantity) ,category
FROM book b JOIN orderitem o 
ON b.bookid = o.bookid 
WHERE Category = 'fiction'
GROUP BY title;

-- Part 5
-- Q1
SELECT c.name , c.customerid , o.orderid
FROM customer c LEFT JOIN  orderheader o
ON o.customerid = c.customerid
ORDER BY c.customerid , o.orderid;
-- Q2
SELECT b.title , o.quantity 
FROM book b LEFT JOIN orderitem o 
ON b.bookid = o.bookid ;
-- Q3
SELECT c.name 
FROM customer c LEFT JOIN orderheader o
ON c.customerid = o.customerid
WHERE o.orderid IS NULL;

-- Part 6
-- Q1
SELECT c.name , o.orderid , SUM(quantity * price ) AS TotalAmount
FROM customer c JOIN orderheader oh 
ON c.customerid = oh.customerid
JOIN orderitem o ON oh.orderid = o.orderid
JOIN book b ON b.bookid = o.bookid
GROUP BY orderid;
-- Q2
SELECT c.name , o.orderid , SUM(quantity ) AS TotalQuantity
FROM customer c JOIN orderheader oh 
ON c.customerid = oh.customerid
JOIN orderitem o ON oh.orderid = o.orderid
JOIN book b ON b.bookid = o.bookid
GROUP BY o.orderid
ORDER BY SUM(quantity) DESC 
LIMIT 1;
-- Q3
SELECT b.category , SUM(o.quantity * b.price) AS TotalRevenue 
FROM book b JOIN orderitem o 
GROUP BY b.category ;
-- Q4
SELECT b.title , COUNT(o.bookid) AS TotaltimesOrdered
FROM book b JOIN orderitem o 
ON b.bookid = o.bookid
GROUP BY b.title 
HAVING COUNT(o.bookid ) >1;




 

