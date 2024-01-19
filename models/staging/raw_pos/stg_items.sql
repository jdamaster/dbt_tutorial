with
    stg_items as (
        select
            l_orderkey order_key,
            uuid uuid,
            l_linenumber line_number,
            l_quantity quantity,
            l_extendedprice base_price,
            (l_extendedprice * l_discount) discount_amount,
            (l_extendedprice * (1 - l_discount)) discount_price,
            (l_extendedprice * (1 - l_discount) * (1 + l_tax)) final_price,
            l_discount discount,
            l_tax tax,
            l_returnflag return_flag,
            l_linestatus line_status
        from {{ source("raw_pos", "lineitem") }}
    )
select *
from stg_items
