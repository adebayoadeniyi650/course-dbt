Project 1 solutions
How many users do we have?
answer: 130 users
Sql:
select count(*) 
from dev_db.dbt_adebayoadeniyi650gmailcom.stg_postgres__users



On average, how many orders do we receive per hour?
Answer: 7.52
sql:
with
orders_hourly as (
select
date_trunc(hour, created_at) as order_hour,
count(*) as order_count
from dev_db.dbt_adebayoadeniyi650gmailcom.stg_postgres__orders 
group by 1

),
final as (
select
avg(order_count) as mean_orders_hourly
from orders_hourly
) 
select * from final




On average, how long does an order take from being placed to being delivered?
Answer: 1133.626
sql: 
WITH time_delivered as (
SELECT order_id, datediff(day,delivered_at,current_date) as day_order_being_placed, 
FROM dev_db.dbt_adebayoadeniyi650gmailcom.stg_postgres__orders
WHERE status = 'delivered')
SELECT avg(day_order_being_placed)
FROM time_delivered




How many users have only made one purchase? Two purchases? Three+ purchases?
Answer: 71
sql:
WITH count_users as (
SELECT o.user_id as user, count(o.order_id) as num_purchase
FROM dev_db.dbt_adebayoadeniyi650gmailcom.stg_postgres__orders o 
GROUP BY 1) 
SELECT  count(case when num_purchase = 1 then user end ) as one_purchase,
count(case when num_purchase = 2 then user end ) as two_purchase,
count(case when num_purchase >= 3 then user end ) as three_purchase,
FROM count_users



Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?
Answer: 16.32
sql:
with cte as 
(
SELECT 
    count(distinct session_id) as sessions_per_hour,
    day(created_at) as session_day,
    hour(created_at) as session_hour
  FROM dev_db.dbt_adebayoadeniyi650gmailcom.stg_postgres__events
  GROUP BY session_day, session_hour
)
SELECT 
  AVG(sessions_per_hour)
FROM cte;