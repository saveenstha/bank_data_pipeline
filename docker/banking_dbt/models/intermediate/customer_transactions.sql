with transactions as (

    select * from {{ ref('stg_transactions') }}

),

accounts as (

    select
        account_id,
        foracid,
        customer_id,
        account_type,
        currency_code
    from {{ ref('stg_accounts') }}

),

customers as (

    select
        customer_id,
        full_name,
        email,
        mobile_number,
        gender,
        date_of_birth,
        address
    from {{ ref('stg_customers') }}

),

joined as (

    select
        t.transaction_id,
        t.transaction_key,
        t.foracid,
        a.account_id,
        a.customer_id,
        c.full_name,
        c.email,
        c.mobile_number,
        c.gender,
        c.date_of_birth,
        c.address,
        a.account_type,
        a.currency_code,
        t.transaction_amount,
        t.amount_remaining,
        t.transaction_type,
        t.digital_flag,
        t.transaction_channel_type,
        t.transaction_timestamp
    from transactions t
    left join accounts a on t.foracid = a.foracid
    left join customers c on a.customer_id = c.customer_id

)

select * from joined
