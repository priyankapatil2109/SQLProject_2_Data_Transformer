-- ============================================================
--              DATA TRANSFORMER SQL PROJECT
-- ============================================================
-- Project: Data Transformer
-- Database: MySQL
-- Purpose: JOINs, Subqueries, Date Functions, String Functions,
--          Window Functions and CASE Expressions
-- ============================================================


-- ============================================================
-- 1. CREATE DATABASE
-- ============================================================

DROP DATABASE IF EXISTS DataTransformer;

CREATE DATABASE DataTransformer;

USE DataTransformer;


-- ============================================================
-- 2. CUSTOMERS TABLE
-- ============================================================

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);


-- ============================================================
-- INSERT DATA INTO CUSTOMERS
-- ============================================================

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, RegistrationDate)
VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com', '2023-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@gmail.com', '2023-02-20'),
(3, 'Michael', 'Brown', 'michael.brown@gmail.com', '2023-03-10'),
(4, 'Emily', 'Davis', 'emily.davis@gmail.com', '2023-04-05'),
(5, 'David', 'Wilson', 'david.wilson@gmail.com', '2023-05-12'),
(6, 'Sarah', 'Miller', 'sarah.miller@gmail.com', '2023-06-18'),
(7, 'Robert', 'Taylor', 'robert.taylor@gmail.com', '2023-07-22'),
(8, 'Olivia', 'Anderson', 'olivia.anderson@gmail.com', '2023-08-30');


-- Check Customers Table
SELECT * FROM Customers;


-- ============================================================
-- 3. ORDERS TABLE
-- ============================================================

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- ============================================================
-- INSERT DATA INTO ORDERS
-- ============================================================

INSERT INTO Orders
(OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 750.00),
(103, 3, '2023-07-05', 1250.75),
(104, 1, '2023-07-10', 500.00),
(105, 4, '2023-07-15', 2250.00),
(106, 5, '2023-08-01', 350.25),
(107, 2, '2023-08-05', 900.00),
(108, 6, '2023-08-10', 450.50),
(109, 3, '2023-08-15', 1500.00),
(110, 7, '2023-09-01', 650.75),
(111, 1, '2023-09-05', 300.00),
(112, 4, '2023-09-10', 1100.00);


-- Check Orders Table
SELECT * FROM Orders;


-- ============================================================
-- 4. EMPLOYEES TABLE
-- ============================================================

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);


-- ============================================================
-- INSERT DATA INTO EMPLOYEES
-- ============================================================

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Department, HireDate, Salary)
VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 45000.00),
(2, 'Susan', 'Lee', 'Marketing', '2021-03-20', 55000.00),
(3, 'Robert', 'Williams', 'IT', '2019-07-10', 85000.00),
(4, 'Linda', 'Taylor', 'HR', '2022-02-05', 50000.00),
(5, 'James', 'Anderson', 'Finance', '2018-11-12', 95000.00),
(6, 'Patricia', 'Thomas', 'IT', '2023-01-18', 65000.00),
(7, 'Daniel', 'Moore', 'Sales', '2020-09-25', 48000.00),
(8, 'Jennifer', 'Martin', 'Marketing', '2021-06-30', 72000.00);


-- Check Employees Table
SELECT * FROM Employees;


-- ============================================================
--                  QUERY 1
--              INNER JOIN
-- ============================================================
-- Retrieve all orders and corresponding customer details
-- where a matching customer exists.


SELECT
    Orders.OrderID,
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Orders
INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID;


-- ============================================================
--                  QUERY 2
--               LEFT JOIN
-- ============================================================
-- Retrieve all customers and their corresponding orders,
-- including customers who have not placed any orders.


SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
LEFT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID;


-- ============================================================
--                  QUERY 3
--               RIGHT JOIN
-- ============================================================
-- Retrieve all orders and their corresponding customers,
-- including orders without a matching customer.


SELECT
    Orders.OrderID,
    Orders.CustomerID,
    Orders.OrderDate,
    Orders.TotalAmount,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email
FROM Customers
RIGHT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID;


-- ============================================================
--                  QUERY 4
--          FULL OUTER JOIN EQUIVALENT
-- ============================================================
-- MySQL does not directly support FULL OUTER JOIN.
-- We can achieve the same result using LEFT JOIN + RIGHT JOIN
-- with UNION.


SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
LEFT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID

UNION

SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
RIGHT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID;


-- ============================================================
--                  QUERY 5
--                SUBQUERY
-- ============================================================
-- Retrieve customers who have placed orders worth more
-- than the average order amount.


SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Orders.OrderID,
    Orders.TotalAmount
FROM Customers
INNER JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders
);


-- ============================================================
--                  QUERY 6
--                SUBQUERY
-- ============================================================
-- Retrieve employees whose salary is above the average salary.


SELECT
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);


-- ============================================================
--                  QUERY 7
--              DATE FUNCTIONS
-- ============================================================
-- Extract the year and month from OrderDate.


SELECT
    OrderID,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;


-- ============================================================
--                  QUERY 8
--              DATE FUNCTIONS
-- ============================================================
-- Calculate the difference in days between OrderDate
-- and the current date.


SELECT
    OrderID,
    OrderDate,
    DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
FROM Orders;


-- ============================================================
--                  QUERY 9
--              DATE FUNCTIONS
-- ============================================================
-- Format OrderDate into a readable format.


SELECT
    OrderID,
    OrderDate,
    DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedOrderDate
FROM Orders;


-- ============================================================
--                  QUERY 10
--             STRING FUNCTIONS
-- ============================================================
-- Concatenate FirstName and LastName to create FullName.


SELECT
    CustomerID,
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;


-- ============================================================
--                  QUERY 11
--             STRING FUNCTIONS
-- ============================================================
-- Replace a part of a string.
-- Example: Replace John with Jonathan.


SELECT
    CustomerID,
    FirstName,
    LastName,
    REPLACE(FirstName, 'John', 'Jonathan') AS ModifiedFirstName
FROM Customers;


-- ============================================================
--                  QUERY 12
--             STRING FUNCTIONS
-- ============================================================
-- Convert FirstName to uppercase and LastName to lowercase.


SELECT
    CustomerID,
    UPPER(FirstName) AS FirstName_Uppercase,
    LOWER(LastName) AS LastName_Lowercase
FROM Customers;


-- ============================================================
--                  QUERY 13
--             STRING FUNCTIONS
-- ============================================================
-- Remove extra spaces from Email.


SELECT
    CustomerID,
    CONCAT('   ', Email, '   ') AS Email_With_Spaces,
    TRIM(CONCAT('   ', Email, '   ')) AS Clean_Email
FROM Customers;


-- ============================================================
--                  QUERY 14
--             WINDOW FUNCTION
-- ============================================================
-- Calculate the running total of TotalAmount for each order.


SELECT
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (
        ORDER BY OrderDate, OrderID
    ) AS RunningTotal
FROM Orders
ORDER BY OrderDate, OrderID;


-- ============================================================
--                  QUERY 15
--             WINDOW FUNCTION
-- ============================================================
-- Rank orders based on TotalAmount using RANK().


SELECT
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount,
    RANK() OVER (
        ORDER BY TotalAmount DESC
    ) AS OrderRank
FROM Orders
ORDER BY OrderRank;


-- ============================================================
--                  QUERY 16
--             CASE EXPRESSION
-- ============================================================
-- Assign a discount based on TotalAmount:
--
-- More than 1000  = 10% discount
-- More than 500   = 5% discount
-- Otherwise       = 0% discount


SELECT
    OrderID,
    CustomerID,
    TotalAmount,

    CASE
        WHEN TotalAmount > 1000 THEN '10% Discount'
        WHEN TotalAmount > 500 THEN '5% Discount'
        ELSE '0% Discount'
    END AS DiscountCategory,

    CASE
        WHEN TotalAmount > 1000 THEN TotalAmount * 0.10
        WHEN TotalAmount > 500 THEN TotalAmount * 0.05
        ELSE 0
    END AS DiscountAmount

FROM Orders;


-- ============================================================
--                  QUERY 17
--             CASE EXPRESSION
-- ============================================================
-- Categorize employees according to salary.
--
-- High Salary   = 75000 or above
-- Medium Salary = 50000 to 74999
-- Low Salary    = below 50000


SELECT
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary,

    CASE
        WHEN Salary >= 75000 THEN 'High Salary'
        WHEN Salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryCategory

FROM Employees;


-- ============================================================
--                  FINAL REPORT
-- ============================================================
-- Display customer name, order information and order amount.


SELECT
    Customers.CustomerID,
    CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName,
    Customers.Email,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
INNER JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
ORDER BY Orders.OrderDate;


-- ============================================================
--              ADDITIONAL SUMMARY REPORT
-- ============================================================
-- Total number of orders and total sales.


SELECT
    COUNT(OrderID) AS TotalOrders,
    SUM(TotalAmount) AS TotalSales,
    AVG(TotalAmount) AS AverageOrderAmount,
    MAX(TotalAmount) AS HighestOrderAmount,
    MIN(TotalAmount) AS LowestOrderAmount
FROM Orders;


-- ============================================================
--              CUSTOMER ORDER SUMMARY
-- ============================================================
-- Show number of orders and total amount spent by each customer.


SELECT
    Customers.CustomerID,
    CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName,
    COUNT(Orders.OrderID) AS NumberOfOrders,
    COALESCE(SUM(Orders.TotalAmount), 0) AS TotalSpent
FROM Customers
LEFT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName
ORDER BY TotalSpent DESC;


-- ============================================================
--              END OF DATA TRANSFORMER PROJECT
-- ============================================================