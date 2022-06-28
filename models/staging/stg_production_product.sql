with source_data as (
    select
        productid
        , productsubcategoryid
        , productmodelid
        , name as product_name
        , productnumber
        , color
        , safetystocklevel
        , reorderpoint
        , standardcost
        , listprice
        , size as product_size
        , sizeunitmeasurecode
        , weightunitmeasurecode
        , weight as product_weight
        , daystomanufacture
        , productline
        , class
        , style
        , sellstartdate
        , sellenddate
        , discontinueddate
    from {{source('adventureworks_data','production_product')}}
)

select *
from source_data