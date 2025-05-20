with customers as (

    select * from {{ ref('stg_customers') }}

),

accounts as (

    select customer_id, count(*) as num_accounts
    from {{ ref('stg_accounts') }}
    group by customer_id

),

transactions as (

    select
        a.customer_id,
        count(t.transaction_id) as total_transactions,
        sum(t.transaction_amount) as total_spent
    from {{ ref('stg_transactions') }} t
    join {{ ref('stg_accounts') }} a on t.foracid = a.foracid
    group by a.customer_id

),

final as (

    select
        c.customer_id,
        c.full_name,
        c.gender,
        c.date_of_birth,
        c.mobile_number,
        c.email,
        c.address,
        a.num_accounts,
        coalesce(t.total_transactions, 0) as total_transactions,
        coalesce(t.total_spent, 0) as total_spent
    from customers c
    left join accounts a on c.customer_id = a.customer_id
    left join transactions t on c.customer_id = t.customer_id

)

select * from final
