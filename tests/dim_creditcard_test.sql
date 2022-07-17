with
    count_creditcard as (
        SELECT
            count(creditcardid) as total
        FROM {{ ref ('dim_creditcard') }}
        WHERE cardtype = 'Distinguish' AND creditcardid = 1176
    )

select * from count_creditcard where total != 1