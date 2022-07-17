with
    count_address as (
        SELECT
            count(addressid) as total
        FROM {{ ref ('dim_address') }}
        WHERE city = 'Nevada' AND addressid = 27
    )

select * from count_address where total != 1