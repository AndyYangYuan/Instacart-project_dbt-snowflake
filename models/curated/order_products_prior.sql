{{ config(materialized='table') }}

select 
    a.*, 
    b.product_id, 
    b.add_to_cart_order,
    b.reordered
from imba.landing.orders a 
join imba.landing.orders_products b
on a.order_id = b.order_id
where a.eval_set = 'prior'
