with
    count_product as (
        SELECT
            count(productid) as total
        FROM {{ ref ('dim_product') }}
        WHERE product_name = 'Flat Washer 6' AND productid = 342
    )

select * from count_product where total != 1