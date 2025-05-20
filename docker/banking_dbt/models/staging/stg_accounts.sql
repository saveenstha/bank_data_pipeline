with source as (

    select * from {{ source('raw', 'account') }}

),

account as (

    select
        account_id,
        customer_id,
        account_type,
        cast(opened_date as date) as opened_date,
        is_active,
        branch
    from source

)

select * from account
