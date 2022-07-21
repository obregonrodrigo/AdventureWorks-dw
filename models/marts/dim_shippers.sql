with staging as (
    select
        shipmethodid
        , ship_name
        , shipbase	
    from {{ref('stg_purchasing_shipmethod')}}
)
    , transformed as (
        select
            row_number() over (order by shipmethodid) as shipper_sk -- auto-incremental surrogate key
            , shipmethodid
            , ship_name
        from staging
)

select *  from transformed