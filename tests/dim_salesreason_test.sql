with
    count_salesreason as (
        SELECT
            count(salesorderid) as total
        FROM {{ ref ('dim_salesreason') }}
        WHERE reason_name = 'Quality' AND salesorderid = 43749
    )

select * from count_salesreason where total != 1