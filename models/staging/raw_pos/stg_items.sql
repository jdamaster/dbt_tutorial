{{ config(materialized='table') }}

with stg_items as (
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
)
select * from stg_items