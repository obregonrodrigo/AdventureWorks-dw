with select_address as (

    select
        addressid
        , addressline1
        , addressline2
        , city
        , stateprovinceid
        , postalcode				
    
    from {{ ref('stg_person_address') }} 	

)
    , select_stateprovince as (
        select
            stateprovinceid
            , stateprovincecode
            , countryregioncode
            , territoryid
            , province_name				
    
        from {{ ref('stg_person_stateprovince') }}
    )

    , select_countryregion as (
        select
            countryregioncode
            , country_name			
    
        from {{ ref('stg_person_countryregion') }}
    )

    , transformed as (
        select
            row_number() over (order by addressid) as address_sk -- auto-incremental surrogate key
            , select_address.addressid
            , select_address.addressline1
            , select_address.addressline2
            , select_address.city
            , select_address.postalcode
            --, select_stateprovince.stateprovinceid
            , select_stateprovince.stateprovincecode
            , select_stateprovince.province_name
            , select_countryregion.countryregioncode
            , select_countryregion.country_name
        from select_address
            left join select_stateprovince
                on select_stateprovince.stateprovinceid = select_address.stateprovinceid
            left join select_countryregion
                on select_countryregion.countryregioncode = select_stateprovince.countryregioncode

)

select  * from transformed