with select_salesperson as (

    select
        businessentityid
        , salesquota
        , bonus
        , commissionpct
        , salesytd
        , saleslastyear
    
    from {{ ref('stg_sales_salesperson') }}

)
    , select_employee as (
        select
            businessentityid as employee_id
            , jobtitle
            , hiredate
            , gender			
    
        from {{ ref('stg_humanresources_employee') }}
    )
    , select_person as (
        select
            businessentityid as person_id
            , full_name
            , persontype
            , emailpromotion			

        from {{ ref('stg_person_person') }}
    )
    , transformed as (
        select
            row_number() over (order by businessentityid) as employee_sk -- auto-incremental surrogate key
            , select_salesperson.businessentityid
            , select_salesperson.salesquota
            , select_salesperson.bonus
            , select_salesperson.commissionpct
            , select_salesperson.salesytd
            , select_salesperson.saleslastyear
            , select_employee.employee_id
            , select_employee.jobtitle
            , select_employee.hiredate
            , select_employee.gender
            , select_person.person_id
            , select_person.full_name
            , select_person.persontype
            --, select_person.emailpromotion

        from select_salesperson
            left join select_employee
                on select_employee.employee_id = select_salesperson.businessentityid
            left join select_person
                on select_person.person_id = select_employee.employee_id

)

select  * from transformed