{{ config(materialized='table') }}

with list
as (select *,
       row_number() over(partition by user_id, product_id order by order_number ASC) as product_seq_time
    from {{ ref('order_products_prior') }}
    )

select 
    product_id,
    count(order_id) as prod_orders,
    sum(reordered) as prod_reorders,
    sum(case when product_seq_time = 1 then 1 else 0 end) as prod_first_orders,
    sum(case when product_seq_time = 2 then 1 else 0 end) as prod_second_orders
from list
group by product_id