with select_product as (

    select
        productid
        , productsubcategoryid
        , productmodelid
        , product_name
        , productnumber
        , color
        , safetystocklevel
        , reorderpoint
        , standardcost
        , listprice
        , product_size
        , sizeunitmeasurecode
        , weightunitmeasurecode
        , product_weight
        , daystomanufacture
        , productline
        , class
        , style
        , sellstartdate
        , sellenddate
        , discontinueddate
        , portifolio				
    
    from {{ ref('stg_production_product') }} 	

)
    , select_category as (
        select
            productcategoryid
            , category_name
    
        from {{ ref('stg_production_productcategory') }}
    )
    , select_productsubcategory as (
        select
            productsubcategoryid
            , productcategoryid
            , subcategory_name
    
        from {{ ref('stg_production_productsubcategory') }}
    )
    , transformed as (
        select
            row_number() over (order by productid) as product_sk -- auto-incremental surrogate key
            , select_product.productid
            , select_product.productmodelid
            , select_product.product_name
            , select_product.productnumber
            , select_product.color
            --, select_product.safetystocklevel
            --, select_product.reorderpoint
            , select_product.standardcost
            , select_product.listprice
            , select_product.product_size
            , select_product.sizeunitmeasurecode
            , select_product.weightunitmeasurecode
            , select_product.product_weight
            , select_product.daystomanufacture
            , select_product.productline
            , select_product.class
            , select_product.style
            , select_product.sellstartdate
            , select_product.sellenddate
            , select_product.discontinueddate
            , select_product.portifolio
            , select_category.productcategoryid
            , select_category.category_name
            , select_productsubcategory.productsubcategoryid
            , select_productsubcategory.subcategory_name

        from select_product
            left join select_productsubcategory
                on select_productsubcategory.productsubcategoryid = select_product.productsubcategoryid
            left join select_category
                on select_productsubcategory.productcategoryid = select_category.productcategoryid

)

select  * from transformed