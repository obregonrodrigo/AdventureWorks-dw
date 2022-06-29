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
    , select_sales_union as (
        select
            salesorderid
            , select_address.address_sk
            , select_creditcard.creditcard_sk
            , select_customer.customer_sk
            , select_employee.employee_sk
            , select_salesreason.reason_sk
            , revisionnumber
            , purchaseordernumber
            , accountnumber
            , customerid
            , salespersonid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , shipmethodid
            , creditcardid
            , currencyrateid
            , orderdate
            , duedate
            , shipdate
            , order_status
            , subtotal
            , taxamt
            , freight
            , totaldue

        from {{ ref('stg_sales_salesorderheader') }} as sales_union
            left join select_employee
                on select_employee.businessentityid = sales_union.salespersonid
            left join select_customer
                on select_customer.customerid = sales_union.customerid
            left join select_address
                on select_address.addressid = sales_union.shiptoaddressid
            left join select_salesreason
                on select_salesreason.salesorderid = sales_union.salesorderid
            left join select_creditcard
                on select_creditcard.creditcard_id = sales_union.creditcardid
    )
    , select_salesdetail_union as (
        select
            salesorderid
            , select_product.product_sk
            , salesorderdetailid
            , productid
            , carriertrackingnumber
            , orderqty
            , unitprice
            , unitpricediscount
            , total_price

        from {{ ref('stg_sales_salesorderheader') }} as salesdetail_union
            left join select_product
                on select_product.productid = salesdetail_union.productid
    )
    , final_fact as (
        select
            select_sales_union.salesorderid
            , select_sales_union.address_sk
            , select_sales_union.creditcard_sk
            , select_sales_union.customer_sk
            , select_sales_union.employee_sk
            , select_sales_union.reason_sk
            , select_salesdetail_union.product_sk
            , select_sales_union.purchaseordernumber
            , select_sales_union.accountnumber
            , select_sales_union.orderdate
            , select_sales_union.duedate
            , select_sales_union.shipdate
            , select_sales_union.order_status
            , select_sales_union.subtotal
            , select_sales_union.taxamt
            , select_sales_union.freight
            , select_sales_union.totaldue
            , select_salesdetail_union.orderqty
            , select_salesdetail_union.unitprice
            , select_salesdetail_union.unitpricediscount
            , select_salesdetail_union.total_price

        from select_sales_union
            left join select_salesdetail_union
                on select_salesdetail_union.salesorderid = select_salesdetail_union.salesorderid
    )

select * from final_fact