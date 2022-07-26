{{ config(materialized='table') }}

select
    c.user_id,
    c.product_id,
    c.up_orders,
    c.up_first_order,
    c.up_last_order,
    c.up_average_cart_position, 
    a.user_orders,
    a.user_period,
    a.user_mean_days_since_prior,
    b.user_total_products,
    b.user_distinct_products,
    b.user_reorder_ratio,
    d.prod_orders,
    d.prod_reorders,
    d.prod_first_orders,
    d.prod_second_orders    

from {{ ref('user_features_1') }} a
join {{ ref('user_features_2') }} b
on a.user_id = b.user_id
right join {{ ref('up_features') }} c
on a.user_id = c.user_id
left join {{ ref('prd_features') }} d
on c.product_id = d.product_id