with stg_orders as (

    select 
    O_ORDERKEY order_key,
    O_ORDERSTATUS order_status,
    O_TOTALPRICE total_price,
    O_ORDERDATE order_date,
    O_ORDERPRIORITY order_priority,
    O_CLERK clerk,
    O_SHIPPRIORITY ship_priority
    from  {{ source('raw_pos', 'orders') }}

)
select * from stg_orders