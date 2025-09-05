CREATE DATABASE CompanyDB
GO
CREATE SCHEMA Sales
GO
CREATE SEQUENCE Sales.employee_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE Sales.employees(
	employee_id INT DEFAULT NEXT VALUE FOR Sales.employee_seq,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	salary DECIMAL(10,2)
)
ALTER TABLE Sales.employees ADD hire_date DATE 

SELECT * FROM Sales.employees;

SELECT first_name, last_name
FROM Sales.employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Sales.employees;

SELECT AVG(salary) AS average_salary
FROM Sales.employees;

SELECT first_name, last_name,hire_date
FROM Sales.employees
WHERE YEAR(hire_date) = 2020;

SELECT first_name, last_name
FROM Sales.employees
WHERE last_name LIKE 'S%';

SELECT TOP 10 first_name, last_name, salary
FROM Sales.employees
ORDER BY salary DESC;

SELECT first_name, last_name, salary
FROM Sales.employees
WHERE salary BETWEEN 40000 AND 60000;

SELECT first_name, last_name, hire_date
FROM Sales.employees
WHERE hire_date IS NULL;

SELECT first_name, last_name, salary
FROM Sales.employees
WHERE salary IN (40000, 45000, 50000);

SELECT first_name, last_name, hire_date
FROM Sales.employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-01-01';

SELECT first_name, last_name, salary
FROM Sales.employees
ORDER BY salary DESC;


SELECT  TOP 5 first_name, last_name
FROM Sales.employees
ORDER BY last_name ASC
;

SELECT first_name, last_name, salary, hire_date
FROM Sales.employees
WHERE salary > 55000 AND YEAR(hire_date) = 2020;

SELECT first_name, last_name
FROM Sales.employees
WHERE first_name IN ('John', 'Jane');

SELECT first_name, last_name, salary, hire_date
FROM Sales.employees
WHERE salary <= 55000 AND hire_date > '2022-01-01';

SELECT first_name, last_name, salary
FROM Sales.employees
WHERE salary > (SELECT AVG(salary) FROM Sales.employees);


SELECT first_name, last_name, salary
FROM Sales.employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT first_name, last_name, hire_date
FROM Sales.employees
WHERE hire_date > '2021-01-01'
ORDER BY last_name, first_name;

SELECT first_name, last_name, salary
FROM Sales.employees
WHERE salary > 50000 AND last_name NOT LIKE 'A%';

SELECT first_name, last_name, salary
FROM Sales.employees
WHERE salary IS NOT NULL;

SELECT first_name, last_name, salary
FROM Sales.employees
WHERE (first_name LIKE '%e%' OR first_name LIKE '%i%' OR last_name LIKE '%e%' OR last_name LIKE '%i%')
AND salary > 45000;
 -- 25. Create a new table named "departments"
CREATE TABLE Sales.departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    manager_id INT,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES Sales.employees(employee_id)
);

-- 26. Assign each employee to a department by adding department_id to employees
ALTER TABLE Sales.employees
ADD department_id INT;

ALTER TABLE Sales.employees
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Sales.departments(department_id);

-- 27. Retrieve all employees with their department names (INNER JOIN)
SELECT e.first_name, e.last_name, d.department_name
FROM Sales.employees e
INNER JOIN Sales.departments d ON e.department_id = d.department_id;

-- 28. Retrieve employees who don’t belong to any department (LEFT JOIN)
SELECT e.first_name, e.last_name
FROM Sales.employees e
LEFT JOIN Sales.departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- 29. Show all departments and their employee count (LEFT JOIN and GROUP BY)
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM Sales.departments d
LEFT JOIN Sales.employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 30. Retrieve the highest-paid employee in each department
SELECT d.department_name, e.first_name, e.last_name, e.salary
FROM Sales.departments d
INNER JOIN Sales.employees e ON d.department_id = e.department_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Sales.employees e2
    WHERE e2.department_id = d.department_id
);