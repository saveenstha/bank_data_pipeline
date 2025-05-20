with source as (

    select * from {{ source('raw', 'transaction') }}

),

transaction as (

    select
        transaction_id,
        account_id,
        card_id,
        product_id,
        transaction_type,
        cast(amount as numeric) as amount,
        cast(transaction_date as timestamp) as transaction_date,
        is_successful
    from source

)

select * from transaction
