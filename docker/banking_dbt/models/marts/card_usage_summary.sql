with cards as (

    select * from {{ ref('stg_cards') }}

),

transactions as (

    select
        foracid,
        count(*) as total_txns,
        sum(transaction_amount) as total_spent
    from {{ ref('stg_transactions') }}
    group by foracid

),

joined as (

    select
        c.card_number,
        c.card_status,
        c.credit_limit,
        c.card_issue_date,
        t.total_txns,
        t.total_spent
    from cards c
    left join transactions t on c.foracid = t.foracid

)

select * from joined
