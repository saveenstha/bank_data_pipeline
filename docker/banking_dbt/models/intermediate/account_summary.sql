with transactions as (

    select * from {{ ref('stg_transactions') }}

),

accounts as (

    select account_id, foracid from {{ ref('stg_accounts') }}

),

joined as (

    select
        a.account_id,
        t.transaction_amount,
        t.transaction_type,
        t.transaction_timestamp
    from transactions t
    left join accounts a on t.foracid = a.foracid

),

aggregated as (

    select
        account_id,
        count(*) as total_transactions,
        sum(transaction_amount) as total_amount,
        avg(transaction_amount) as average_transaction_amount,
        max(transaction_timestamp) as last_transaction_date,
        sum(case when transaction_type = 'C' then transaction_amount else 0 end) as total_credits,
        sum(case when transaction_type = 'D' then transaction_amount else 0 end) as total_debits
    from joined
    group by account_id

)

select * from aggregated
