select* 
from superstore_table;
--------------------------------------------
-- Product performance Analysis Dashboard --
--------------------------------------------
select 
`order id`,
`order date`, 
`ship date`, 
`ship mode`, 
`customer Id`, 
segment, 
country, 
state, 
`product id`, 
category, 
`sub-category`, 
sales as Revenue, 
discount, 
quantity, 
profit 
from superstore_table;

--------------------------------------------
-- customer Behaviour Analysis Dashboard --
--------------------------------------------
select 
`customer Id` as customer_id, 
`customer name` as customer_name,
count(distinct `order id`) as Total_order,
sum(sales) as Total_revenue, 
sum(quantity) as Total_quantity, 
sum(profit) as Total_profit, 
Avg(discount) as AVG_Discount, 
Case
	when count(distinct `order id`) > 15 then 'Loyal' 
    when count(distinct `order id`) between 5 and 15 then 'Regular customer' 
    else 'occasional'
End as Customer_segmentation
From superstore_table
group by customer_ID, customer_name;


-------------------------------
-- Sales Analysis dashboard --
-------------------------------
select 
`order id`, 
`order date`, 
`ship date`, 
`ship mode`, 
`customer id`, 
segment,
state, 
city, 
region, 
category, 
`sub-category`, 
sales, 
Quantity, 
Discount, 
Profit, 
YEAR(STR_TO_DATE(`order date`, '%d/%m/%Y')) AS order_year,
DATE_FORMAT(
    STR_TO_DATE(`order date`, '%d/%m/%Y'),
    '%Y-%m'
) AS order_month,
DATEDIFF(
        STR_TO_DATE(`ship date`, '%d/%m/%Y'), 
        STR_TO_DATE(`order date`, '%d/%m/%Y')
    ) AS days_difference, 
    CASE
    WHEN profit > 0 THEN 'Profit'

    WHEN profit < 0 THEN 'Loss'

    ELSE 'Break Even'
END AS profit_status
        From superstore_table;

-- Texas investigation---

SELECT category,`Sub-Category`, SUM(profit) AS total_profit, state
FROM superstore_table
WHERE state = 'Texas'
GROUP BY state, category, `Sub-Category`
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

select
 `sub-Category`, 
 state,
 sum(profit) as total_profit
 from superstore_table
 where state = 'Texas'
 group by state, `sub-category`
 order by total_profit asc;

