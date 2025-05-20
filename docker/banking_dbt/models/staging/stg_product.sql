with source as (

    select * from {{ source('raw', 'product') }}

),

product as (

    select
        product_id,
        product_type,
        product_name,
        cast(created_at as timestamp) as created_at
    from source

)

select * from product
