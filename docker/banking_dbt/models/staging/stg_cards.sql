with source as (

    select * from {{ source('raw', 'cards') }}

),

card as (

    select
        card_id,
        customer_id,
        card_type,
        cast(limit_amount as numeric) as limit_amount,
        cast(issued_date as date) as issued_date,
        is_active
    from source

)

select * from card
