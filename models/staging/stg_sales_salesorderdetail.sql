with source_data as (
    select
        salesorderdetailid
        , salesorderid
        , productid
        , specialofferid
        , carriertrackingnumber
        , orderqty
        , unitprice
        , unitpricediscount
        , (unitprice * orderqty) * (1 - unitpricediscount)  as total_price
        , case
	        when specialofferid = 1 then 'No'
	        else 'Yes'
          end as promotion
    from {{source('adventureworks_data','sales_salesorderdetail')}}
)

select *
from source_data