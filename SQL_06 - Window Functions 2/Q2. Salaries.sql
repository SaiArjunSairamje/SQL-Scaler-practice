Q2. Salaries
(LeetCode: 1468. Calculate Salaries) 

Problem Description:
Write a query to find the salaries of the employees after applying taxes. Round the salary to the nearest integer.

The tax rate is calculated for each company based on the following criteria:

* 0% If the max salary of any employee in the company is less than $1000.
* 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
* 49% If the max salary of any employee in the company is greater than $10000.

1. Select MySQL 8.0 in the drop-down.
2. The salary after taxes = salary - salary x (taxes percentage / 100).
3. Order the output by company_id, and employee_id in ascending order.

Sample Input:

Table: salaries
+------------+-------------+---------------+--------+
| company_id | employee_id | employee_name | salary |
+------------+-------------+---------------+--------+
| 1          | 1           | Tony          | 2000   |
| 1          | 2           | Pronub        | 21300  |
| 1          | 3           | Tyrrox        | 10800  |
| 2          | 1           | Pam           | 300    |
| 2          | 7           | Bassem        | 450    |
| 2          | 9           | Hermione      | 700    |
| 3          | 7           | Bocaben       | 100    |
| 3          | 2           | Ognjen        | 2200   |
| 3          | 13          | Nyancat       | 3300   |
| 3          | 15          | Morninngcat   | 1866   |
+------------+-------------+---------------+--------+

Sample Output:
+------------+-------------+---------------+--------+
| company_id | employee_id | employee_name | salary |
+------------+-------------+---------------+--------+
| 1          | 1           | Tony          | 1020   |
| 1          | 2           | Pronub        | 10863  |
| 1          | 3           | Tyrrox        | 5508   |
| 2          | 1           | Pam           | 300    |
| 2          | 7           | Bassem        | 450    |
| 2          | 9           | Hermione      | 700    |
| 3          | 7           | Bocaben       | 76     |
| 3          | 2           | Ognjen        | 1672   |
| 3          | 13          | Nyancat       | 2508   |
| 3          | 15          | Morninngcat   | 5911   |
+------------+-------------+---------------+--------+

Sample Explanation:

* For company 1, the max salary is 14609. Employees in company 1 have taxes = 49%
* For company 2, the max salary is 800. Employees in company 2 have taxes = 0%

# Solution
SELECT 
    company_id, 
    employee_id, 
    employee_name,
    ROUND(CASE
            WHEN MAX(salary) OVER(PARTITION BY company_id) < 1000 
            THEN salary
            WHEN MAX(salary) OVER(PARTITION BY company_id) BETWEEN 1000 AND 10000 
            THEN salary - (salary * 0.24) 
            ELSE salary - (salary * 0.49)
        END, 0) AS salary
FROM salaries 
ORDER BY company_id, employee_id;
