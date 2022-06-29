with select_reasons as (
    select
        salesreason_id
        , reason_name
        , reasontype			
    
    from {{ ref('stg_sales_salesreason') }}
)
    , select_orderheader_reason as (
        select
            salesorderid
            , salesreasonid
            , orderreason_id
        from {{ ref('stg_sales_salesorderheadersalesreason') }}
    )
    , transformed as (
        select
            row_number() over (order by orderreason_id) as reason_sk -- auto-incremental surrogate key
            , select_orderheader_reason.salesorderid
            , select_reasons.salesreason_id
            , select_reasons.reason_name
            , select_reasons.reasontype

        from select_orderheader_reason
            left join select_reasons
                on select_reasons.salesreason_id = select_orderheader_reason.salesreasonid

)

select  * from transformed