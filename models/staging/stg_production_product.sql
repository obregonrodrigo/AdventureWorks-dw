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
        , case
	        when sellenddate IS NULL then 1
	        else 0
          end as portifolio
    from {{source('adventureworks_data','production_product')}}
)

select *
from source_data