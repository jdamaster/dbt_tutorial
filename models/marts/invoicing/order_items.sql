with stg_items as (
    select * from {{ ref('stg_items') }}  
),
stg_orders as (
    select * from {{ ref('stg_orders') }}
),
order_items as (
    select stg_items.*, stg_orders.order_date, stg_orders.order_status, stg_orders.order_priority, stg_orders.ship_priority
    from stg_items
    left join stg_orders using(order_key)
)
select * from order_items
