with
    count_customer as (
        SELECT
            count(customerid) as total
        FROM {{ ref ('dim_customer') }}
        WHERE full_name = 'Edwin Shan' AND customerid = 12268
    )

select * from count_customer where total != 1