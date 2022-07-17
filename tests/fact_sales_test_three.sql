-- sum total orderdue
with
    sum_order as (
        SELECT
            sum(totaldue) as total
        FROM {{ ref ('fact_sales') }}
        WHERE orderdate between '2012-12-01' and '2012-12-31' 
    )

select * from sum_order where total != 3176848.1687