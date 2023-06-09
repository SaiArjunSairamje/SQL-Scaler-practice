Q3. The Most Recent Three Orders

Problem Statement:
Write a query to find the most recent three orders of each user. If a user ordered three or less than three orders, return all of their orders.
Return the result table ordered by customer_name in ascending order and in case of a tie by the customer_id in ascending order. If there is still a tie, order them by order_date in descending order.

Table: customers

Table: orders

Explanation:
* Winston has 4 orders, we discard the order of "2020-06-10" because it is the oldest order.
* Annabelle has only 2 orders, we return them.
* Jonathan has exactly 3 orders.
* Marwan ordered only one time.

# Solution
SELECT 
    c.name AS customer_name, 
    c.customer_id, 
    o.order_id,
     o.order_date
FROM customers AS c
JOIN orders AS o 
ON c.customer_id = o.customer_id
WHERE (SELECT COUNT(*) 
        FROM orders AS o2
        # when using SELF JOIN, it is easy to forgot to connect them first
        WHERE o.customer_id = o2.customer_id AND o.order_date< o2.order_date) <= 2
ORDER BY customer_name, c.customer_id, o.order_date DESC;

# Alternate Solution - 1
SELECT
    name as customer_name,
    customer_id,
    order_id,
    order_date
FROM (SELECT 
        c.name,
        o.customer_id,
        o.order_id,
        o.order_date,
        DENSE_RANK() OVER(PARTITION BY o.customer_id ORDER BY o.order_date DESC) as rnk
    FROM orders as o 
    JOIN customers as c
    ON o.customer_id = c.customer_id) AS x
WHERE rnk < 4
ORDER BY 1, 2, 4 DESC

# Alternate Solution - 2
SELECT customer_name, customer_id, order_id, order_date
FROM (SELECT
        c.name AS customer_name,
        c.customer_id AS customer_id,
        o.order_id AS order_id,
        o.order_date AS order_date,
        RANK() oOVERver(PARTITION BY customer_id ORDER BY order_date DESC) AS rnk
      FROM orders o
      JOIN customers c
      ON o.customer_id = c.customer_id
    ) AS t
WHERE rnk <= 3
ORDER BY customer_name, customer_id, order_date DESC;
