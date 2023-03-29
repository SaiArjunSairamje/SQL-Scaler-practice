Q1. 5th highest

Problem Statement:

Show the details of the employees who have the 5th highest salary in each job category.

Return the columns 'employee_id', 'first_name', 'job_id'.
Note:

Select MySQL 8.0 in the drop-down.
Use the employees table.
(NOTE: HR Dataset used)

# Solution
SELECT  
    emp.employee_id,
    emp.first_name,
    emp.job_id
FROM (SELECT 
        employee_id,
        first_name,
        job_id,
        DENSE_RANK() OVER (PARTITION BY job_id ORDER BY salary desc) AS j_id
    FROM employees) AS emp
WHERE emp.j_id = 5;

# Alternate Solution
SELECT employee_id, first_name, job_id 
FROM (SELECT employee_id, first_name, job_id, 
        DENSE_RANK() OVEER (PARTITION BY job_id ORDER BY salary desc) "salary_rank" 
        FROM employees) AS t 
WHERE salary_rank = 5;
