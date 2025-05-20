with source as (

    select * from {{ source('raw', 'product') }}

),
products as (
    select
        product_scheme_code as product_id,
        product_scheme_type,
        product_scheme_category,
        "Product_scheme_sub_category" as product_scheme_sub_category
    from source
)

select * from products