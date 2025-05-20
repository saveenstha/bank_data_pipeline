with source as (

    select * from {{ source('raw', 'customer') }}

),

customer as (

    select
        customer_id,
        full_name,
        gender,
        date_of_birth,
        cast(joined_date as date) as joined_date,
        email,
        phone,
        address,
        is_active
    from source

)

select * from customer
