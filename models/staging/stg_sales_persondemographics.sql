with source_data as (
    select
        businessentityid
        , totalpurchaseytd
        , datefirstpurchase
        , birthdate
        , maritalstatus
        , yearlyincome
        , gender
        , totalchildren
        , numberchildrenathome
        , education
        , occupation
        , homeownerflag
        , numbercarsowned
    from {{source('adventureworks_data','sales_vpersondemographics')}}
)

select *
from source_data