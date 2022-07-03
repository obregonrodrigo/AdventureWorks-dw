with select_creditcard as (

    select
        creditcardid
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
            row_number() over (order by select_creditcard.creditcardid) as creditcard_sk -- auto-incremental surrogate key
            , select_creditcard.creditcardid
            , select_creditcard.cardtype
            , select_creditcard.cardnumber
            , select_personcreditcard.businessentityid

        from select_creditcard
            left join select_personcreditcard
                on select_personcreditcard.creditcardid = select_creditcard.creditcardid

)

select  * from transformed