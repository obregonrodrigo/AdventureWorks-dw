-- sum quantity in orderqty
with
    sum_quantity as (
        SELECT
            sum(orderqty) as total
        FROM {{ ref ('fact_sales') }}
        WHERE orderdate between '2012-01-01' and '2012-01-31' 
    )

select * from sum_quantity where total != 3967