with items as(
    select * from {{ ref('stg_items') }}
)
-- Test if there are items with 0 or negative quantity
select uuid, quantity
from items
where quantity <=0 