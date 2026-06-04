CREATE DATABASE company_sales;
USE company_sales;


CREATE TABLE sales (
    id INT PRIMARY KEY,
    employee VARCHAR(50),
    department VARCHAR(10),
    sales_amount INT,
    sale_date DATE
);


INSERT INTO sales VALUES
(1,'Alice','A',1000,'2024-01-01'),
(2,'Bob','B',1500,'2024-01-02'),
(3,'Alice','A',2000,'2024-01-03'),
(4,'Bob','B',1800,'2024-01-04'),
(5,'Alice','A',1200,'2024-01-05'),
(6,'Bob','B',1600,'2024-01-06');


SELECT * FROM sales;

-- 1. Total sales per employee (Running Total)
SELECT *,
SUM(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS running_total
FROM sales;

-- 2. Row number per employee
SELECT *,
ROW_NUMBER()
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS row_num
FROM sales;

-- 3. Rank of sales per department
SELECT *,
RANK()
OVER(
PARTITION BY department
ORDER BY sales_amount DESC
) AS rank_sales
FROM sales;

-- 4. Lead (Next sale) per employee
SELECT *,
LEAD(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS next_sale
FROM sales;

-- 5. Lag (Previous sale) per employee
SELECT *,
LAG(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS previous_sale
FROM sales;

-- 6. Average sales per employee
SELECT *,
AVG(sales_amount)
OVER(
PARTITION BY employee
) AS avg_sales
FROM sales;

-- 7. First and Last sales per employee
SELECT *,

FIRST_VALUE(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS first_sale,

LAST_VALUE(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING
) AS last_sale

FROM sales;

-- 8. Dense Rank (No gaps)
SELECT *,
DENSE_RANK()
OVER(
PARTITION BY department
ORDER BY sales_amount DESC
) AS dense_rank_sales
FROM sales;

-- 9. Cumulative average per employee
SELECT *,

AVG(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS cumulative_avg

FROM sales;

-- 10. Highest sale per employee
SELECT *,

MAX(sales_amount)
OVER(
PARTITION BY employee
) AS highest_sale

FROM sales;

-- 11. Sales difference from previous record
SELECT *,

sales_amount -
LAG(sales_amount)
OVER(
PARTITION BY employee
ORDER BY sale_date
)

AS sales_difference

FROM sales;

-- 12. Cumulative count of sales per employee
SELECT *,

COUNT(*)
OVER(
PARTITION BY employee
ORDER BY sale_date
) AS cumulative_count

FROM sales;

-- 13. Show if sale is above average per employee
SELECT *,

CASE
WHEN sales_amount >
AVG(sales_amount)
OVER(PARTITION BY employee)

THEN 'Above Average'

ELSE 'Below Average'

END AS status

FROM sales;

-- 14. Find second highest sale per employee
SELECT *
FROM (

SELECT *,

DENSE_RANK()
OVER(
PARTITION BY employee
ORDER BY sales_amount DESC
) AS rank_num

FROM sales

) x

WHERE rank_num = 2;
