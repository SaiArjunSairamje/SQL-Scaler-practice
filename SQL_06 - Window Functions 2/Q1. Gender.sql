Q1. Gender
(LeetCode: 2308. Arrange Table by Gender)

Problem Description :
Write a query to reorder the entries of the genders table so that "female," "other," and "male" appear in that order in alternating rows.
The table should be rearranged such that the IDs of each gender are sorted in ascending order.
* Return the column's user_id and gender.

Sample Input:

Table: genders
+---------+--------+
| user_id | gender |
+---------+--------+
| 1       | male   |
| 2       | other  |
| 3       | other  |
| 4       | male   |
| 5       | female |
| 6       | male   |
| 7       | female |
+---------+--------+

Sample Output: 
+---------+--------+
| user_id | gender |
+---------+--------+
| 5       | female |
| 2       | other  |
| 1       | male   |
| 7       | female |
| 3       | other  |
| 4       | male   |
+---------+--------+

Explanation:
The output is displayed in this order: "female," "other," and "male" and the ids of each gender are also sorted in ascending order.

# Solution
SELECT
    user_id,
    gender
FROM (SELECT
        user_id,
        gender,
        ROW_NUMBER() OVER(PARTITION BY gender ORDER BY user_id ASC) AS id_order,
        CASE gender
            WHEN "female" THEN 1
            WHEN "other" THEN 2
            ELSE 3
        END AS gender_order
    FROM genders) AS OrderedGenders
ORDER BY id_order ASC, gender_order ASC;

# Alternate Solution
SELECT 
   user_id, 
   gender 
FROM (SELECT 
         *,
         ROW_NUMBER() OVER(PARTITION BY gender ORDER BY user_id ASC) AS rn,
         CASE 
            WHEN gender = "female" THEN 0
            WHEN gender = "other" THEN 1
            ELSE 2 
         END as new
      FROM genders
      ORDER BY rn, new) AS e;
