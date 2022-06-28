with source_data as (
    select
        businessentityid
        , persontype
        , firstname
        , middlename
        , lastname
        , case
	        when middlename != '' then concat(firstname, ' ', middlename, ' ', lastname)
	        else concat(firstname, ' ', lastname)
          end as full_name
        , emailpromotion

    from {{source('adventureworks_data','person_person')}}
)

select *
from source_data