-- count salesorderid
with
    count_order as (
        SELECT
            count(distinct(salesorderid)) as total
        FROM {{ ref ('fact_sales') }}
        WHERE orderdate between '2013-04-01' and '2013-04-30' 
    )

select * from count_order where total != 428