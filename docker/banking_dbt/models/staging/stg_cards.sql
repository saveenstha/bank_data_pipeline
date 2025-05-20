-- noinspection SqlNoDataSourceInspection
with source as (

    select * from {{ source('raw', 'cards') }}

),

cards as (

    select
        card_number,
        account_number,
        aty_code,
        card_status,
        foracid,
        car_code,
        product_code,
        cast(acc_paym_mode as numeric) as acc_payment_mode,
        cast(credit_limit as numeric) as credit_limit,
        cast(car_create_date as date) as card_issue_date
    from source

)

select * from cards
