with source_data as (
    select
        businessentityid
        , nationalidnumber
        , loginid
        , jobtitle
        , birthdate
        , maritalstatus
        , gender
        , hiredate
    from {{source('adventureworks_data','humanresources_employee')}}
)

select *
from source_data