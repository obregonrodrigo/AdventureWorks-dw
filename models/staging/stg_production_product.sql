with source_data as (
    select
        productid
        , name as product_name
        , productnumber
        , color
        , safetystocklevel
        , reorderpoint
    from {{source('adventureworks_data','production_product')}}
)

select *
from source_data