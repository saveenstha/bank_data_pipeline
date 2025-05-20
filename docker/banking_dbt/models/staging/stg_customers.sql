with source as (

    select * from {{ source('raw', 'customer') }}

),

customers as (

    select
        cif_id as customer_id,
        cust_first_name,
        cust_middle_name,
        cust_last_name,
        full_name,
        cust_type,
        cust_dob as date_of_birth,
        gender,
        address_line as address,
        employment_status,
        occupation,
        blacklisted,
        pan,
        email,
        cust_community,
        rating,
        constitution_code,
        constitution_code_desc,
        mobile_number,
        account_relationship_date
    from source

)

select * from customers
