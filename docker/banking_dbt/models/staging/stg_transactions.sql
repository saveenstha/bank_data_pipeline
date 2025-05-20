with source as (

    select * from {{ source('raw', 'transaction') }}

),

transactions as (

    select
        transaction_id,
        transaction_key,
        foracid,
        cast(transaction_amount as numeric) as transaction_amount,
        cast(amount_left as numeric) as amount_remaining,
        p_tran_type as transaction_type,
        digital_flag,
        transaction_channel_type,
        cast(timestamp as timestamp) as transaction_timestamp
    from source

)

select * from transactions
