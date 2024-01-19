
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with stg_orders as (

    select 
    O_ORDERKEY order_key,
    O_ORDERSTATUS order_status,
    O_TOTALPRICE total_price,
    O_ORDERDATE order_date,
    O_ORDERPRIORITY order_priority,
    O_CLERK clerk,
    O_SHIPPRIORITY ship_priority
    from  RAW_POS.orders

),

stg_items as (
    select 
    L_ORDERKEY order_key,
    UUID uuid,
    L_LINENUMBER line_number,
    L_QUANTITY quantity,
    L_EXTENDEDPRICE base_price,
    (l_extendedprice * (1-l_discount)) discount_price,
    (l_extendedprice * (1-l_discount) * (1+l_tax)) final_price,
    L_DISCOUNT discount,
    L_TAX tax,
    L_RETURNFLAG return_flag,
    L_LINESTATUS line_status
    from  RAW_POS.lineitem
),
order_items as (
    select stg_items.*, stg_orders.order_date, stg_orders.order_status, stg_orders.order_priority, stg_orders.ship_priority
    from stg_items
    left join stg_orders on stg_items.order_key = stg_orders.order_key
)
select * from order_items
