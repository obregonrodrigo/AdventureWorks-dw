with source_data as (
    select
        productcategoryid
        , name as category_name
    from {{source('adventureworks_data','production_productcategory')}}
)

select *
from source_data