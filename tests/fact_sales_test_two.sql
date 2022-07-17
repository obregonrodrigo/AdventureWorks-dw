-- count salesorderid
with
    count_order as (
        SELECT
            count(distinct(salesorderid)) as total
        FROM {{ ref ('fact_sales') }}
        WHERE orderdate between '2012-01-01' and '2012-01-31' 
    )

select * from count_order where total != 3967