with select_address as (
    select *
    from  {{ ref('dim_address') }}
)
    , select_creditcard as (
        select *
        from {{ ref('dim_creditcard') }}
    )
    , select_customer as (
        select *
        from {{ ref('dim_customer') }}
    )
    , select_employee as (
        select *
        from {{ ref('dim_employee') }}
    )
    , select_product as (
        select *
        from {{ ref('dim_product') }}
    )
    , select_salesreason as (
        select *
        from {{ ref('dim_salesreason') }}
    )
    , select_details as (
        select *
        from {{ ref('stg_sales_salesorderdetail') }}
    )
    , select_fullsales as (
        select
            fullsales.salesorderid
            , fullsales.customerid
            , fullsales.salespersonid
            , fullsales.territoryid
            , fullsales.billtoaddressid
            , fullsales.shiptoaddressid
            , fullsales.shipmethodid
            , fullsales.creditcardid
            , fullsales.currencyrateid
            , fullsales.revisionnumber
            , fullsales.purchaseordernumber
            , fullsales.accountnumber
            , fullsales.orderdate
            , fullsales.shipdate
            , fullsales.order_status
            , fullsales.subtotal
            , fullsales.taxamt
            , fullsales.freight
            , select_details.salesorderdetailid
            , select_details.productid
            , select_details.carriertrackingnumber
            , select_details.orderqty
            , select_details.unitprice
            , select_details.unitpricediscount
            , select_details.total_price

        from {{ ref('stg_sales_salesorderheader') }} as fullsales
            left join select_details
                on select_details.salesorderid = fullsales.salesorderid
    )
    , final_fact as (
        select
            select_fullsales.salesorderid
            , select_address.address_sk
            , select_creditcard.creditcard_sk
            , select_customer.customer_sk
            , select_employee.employee_sk
            , select_salesreason.reason_sk
            , select_fullsales.salesorderdetailid
            , select_fullsales.customerid
            , select_fullsales.salespersonid
            , select_fullsales.territoryid
            , select_fullsales.billtoaddressid
            , select_fullsales.shiptoaddressid
            , select_fullsales.shipmethodid
            , select_fullsales.creditcardid
            , select_fullsales.currencyrateid
            , select_fullsales.productid
            , select_fullsales.revisionnumber
            , select_fullsales.purchaseordernumber
            , select_fullsales.accountnumber
            , select_fullsales.orderdate
            , select_fullsales.shipdate
            , select_fullsales.order_status
            , select_fullsales.subtotal
            , select_fullsales.taxamt
            , select_fullsales.freight
            , select_fullsales.carriertrackingnumber
            , select_fullsales.orderqty
            , select_fullsales.unitprice
            , select_fullsales.unitpricediscount
            , select_fullsales.total_price

        from select_fullsales
            left join select_employee
                on select_employee.businessentityid = select_fullsales.salespersonid
            left join select_customer
                on select_customer.customerid = select_fullsales.customerid
            left join select_address
                on select_address.addressid = select_fullsales.shiptoaddressid
            left join select_salesreason
                on select_salesreason.salesorderid = select_fullsales.salesorderid
            left join select_creditcard
                on select_creditcard.creditcard_id = select_fullsales.creditcardid
    )

    select * from final_fact