# SQL Project 2 – Data Transformer

## 📌 Project Overview

**Data Transformer** is a MySQL-based SQL project created to practice and demonstrate important SQL concepts used in data analysis.

The project works with customer, order, and employee data and demonstrates how SQL can be used to combine data, perform calculations, extract information, manipulate text, analyze data using window functions, and categorize records using CASE expressions.

---

## 🎯 Objective

The main objectives of this project are:

- To understand and implement different types of SQL JOINs.
- To use subqueries for data analysis.
- To work with SQL date functions.
- To manipulate and format string data.
- To use window functions for advanced analysis.
- To use CASE expressions for data categorization.
- To create useful reports from relational database tables.

---

## 🗄️ Database Structure

The project uses a database named:

**DataTransformer**

The database contains three main tables:

### 1. Customers

Stores information about customers.

| Column | Description |
|---|---|
| CustomerID | Unique ID of the customer |
| FirstName | Customer's first name |
| LastName | Customer's last name |
| Email | Customer's email address |
| RegistrationDate | Customer registration date |

---

### 2. Orders

Stores information about customer orders.

| Column | Description |
|---|---|
| OrderID | Unique ID of the order |
| CustomerID | ID of the customer who placed the order |
| OrderDate | Date of the order |
| TotalAmount | Total value of the order |

**Relationship:**

`Customers.CustomerID → Orders.CustomerID`

---

### 3. Employees

Stores information about employees.

| Column | Description |
|---|---|
| EmployeeID | Unique ID of the employee |
| FirstName | Employee's first name |
| LastName | Employee's last name |
| Department | Employee department |
| HireDate | Employee hiring date |
| Salary | Employee salary |


