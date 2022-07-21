with
    count_employee as (
        SELECT
            count(businessentityid) as total
        FROM {{ ref ('dim_employee') }}
        WHERE hiredate = '2012-05-30' AND businessentityid = 289
    )

select * from count_employee where total != 1