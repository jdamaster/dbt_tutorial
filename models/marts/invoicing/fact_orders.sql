with items as (
    select * from {{ ref('stg_order_items') }}
),
totals as (
    select order_key,
    sum(discount_amount) discount_total,
    sum(final_price) order_total
    from items
    group by 1
)
select 
items.order_key,
coalesce(totals.discount_total,0) discount, 
coalesce(totals.order_total, 0) total
from items
left join totals using(order_key)

