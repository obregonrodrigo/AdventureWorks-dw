with source_data as (
    select
        productsubcategoryid
        , productcategoryid
        , name as subcategory_name
    from {{source('adventureworks_data','production_productcategory')}}
)

select *
from source_data