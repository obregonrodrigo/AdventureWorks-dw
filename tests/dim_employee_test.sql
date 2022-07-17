with
    count_employee as (
        SELECT
            count(businessentityid) as total
        FROM {{ ref ('dim_employee') }}
        WHERE hiredate = '2008-03-17' AND businessentityid = 62
    )

select * from count_employee where total != 1