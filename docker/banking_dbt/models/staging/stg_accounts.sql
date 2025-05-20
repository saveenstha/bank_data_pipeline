with source as (

    select * from {{ source('raw', 'account') }}

),

accounts as (

    select
        acid as account_id,
        foracid,
        cif_id as customer_id,
        acct_opn_date as opened_date,
        account_status,
        cast(lien_amt as numeric) as lien_amount,
        product_schm_code as product_id,
        schm_type as account_type,
        cast(sanct_lim as numeric) as sanctioned_limit,
        acct_crncy_code as currency_code,
        del_flg as is_deleted,
        acct_cls_flg as is_closed,
        cast(drwng_power as numeric) as drawing_power,
        cast(interest_rate as numeric) as interest_rate,
        cast(accrued_interest as numeric) as accrued_interest,
        limit_b2kid,
        cast(clr_bal_amt as numeric) as clear_balance
    from source

)

select * from accounts
