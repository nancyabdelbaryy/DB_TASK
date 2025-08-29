CREATE DATABASE task1_2
-- 1. Create Employees table
CREATE TABLE Employees (
    ID INT,
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- 2. Add a new column Department
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 3. Remove the Salary column
ALTER TABLE Employees
DROP COLUMN Salary;

-- 4. Rename Department to DeptName (SQL Server uses sp_rename)
EXEC sp_rename 'Employees.Department', 'DeptName', 'COLUMN';

-- 5. Create Projects table
CREATE TABLE Projects (
    ProjectID INT,
    ProjectName VARCHAR(100)
);

-- 6. Add primary key on ID in Employees
ALTER TABLE Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY (ID);

-- 7. Add unique constraint on Name
ALTER TABLE Employees
ADD CONSTRAINT UQ_Employees_Name UNIQUE (Name);

-- 8. Create Customers table
CREATE TABLE Customers (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Status VARCHAR(20)
);

-- 9. Add unique constraint on FirstName + LastName
ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_Name UNIQUE (FirstName, LastName);

-- 10. Create Orders table
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2)
);

-- 11. Add check constraint to ensure TotalAmount > 0
ALTER TABLE Orders
ADD CONSTRAINT CHK_TotalAmount CHECK (TotalAmount > 0);

-- 12. Create schema Sales
CREATE SCHEMA Sales;

-- Move Orders table to Sales schema
ALTER SCHEMA Sales TRANSFER dbo.Orders;

-- 13. Rename Orders to SalesOrders
EXEC sp_rename 'Sales.Orders', 'SalesOrders';
