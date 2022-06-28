with select_creditcard as (

    select
        creditcard_id
        , cardtype
        , cardnumber				
    
    from {{ ref('stg_sales_creditcard') }} 	

)
    , select_personcreditcard as (
        select
            businessentityid
            , creditcardid			
    
        from {{ ref('stg_sales_personcreditcard') }}
    )
    , transformed as (
        select
            row_number() over (order by creditcard_id) as creditcard_sk -- auto-incremental surrogate key
            , select_creditcard.creditcard_id
            , select_creditcard.cardtype
            , select_creditcard.cardnumber
            , select_personcreditcard.businessentityid

        from select_creditcard
            left join select_personcreditcard
                on select_personcreditcard.creditcardid = select_creditcard.creditcard_id

)

select  * from transformed