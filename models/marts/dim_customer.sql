with select_customer as (

    select
        customerid
        , personid
        , storeid
        , territoryid				
    
    from {{ ref('stg_sales_customer') }}
    where personid !=0

)
    , select_person as (
        select
            businessentityid
            , persontype
            , full_name
            , emailpromotion			
    
        from {{ ref('stg_person_person') }}
    )
    , transformed as (
        select
            row_number() over (order by customerid) as customer_sk -- auto-incremental surrogate key
            , select_customer.customerid
            , select_customer.storeid
            , select_person.businessentityid
            , select_person.full_name

        from select_customer
            left join select_person
                on select_person.businessentityid = select_customer.personid

)

select  * from transformed