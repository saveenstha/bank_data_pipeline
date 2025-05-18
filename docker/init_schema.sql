CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE customers (
    cif_id VARCHAR(20) PRIMARY KEY,
    cust_first_name VARCHAR(100),
    cust_middle_name VARCHAR(100),
    cust_last_name VARCHAR(100),
    full_name VARCHAR(200),
    cust_type VARCHAR(20),
    cust_dob DATE,
    gender CHAR(1),
    address_line VARCHAR(255),
    employment_status VARCHAR(100),
    occupation VARCHAR(100),
    blacklisted CHAR(1),
    pan VARCHAR(20),
    email VARCHAR(255),
    cust_community VARCHAR(100),
    rating VARCHAR(20),
    constitution_code VARCHAR(20),
    constitution_code_desc VARCHAR(100),
    mobile_number VARCHAR(20),
    account_relationship_date DATE
);

CREATE TABLE products (
    product_scheme_code VARCHAR(20) PRIMARY KEY,
    product_scheme_type VARCHAR(50),
    product_scheme_category VARCHAR(50),
    product_scheme_sub_category VARCHAR(50)
);

CREATE TABLE accounts (
    acid VARCHAR(20) PRIMARY KEY,
    foracid VARCHAR(30) UNIQUE,
    cif_id VARCHAR(20),
    acct_opn_date TIMESTAMP,
    account_status CHAR(1),
    lien_amt DECIMAL(15,2),
    product_schm_code VARCHAR(20),
    schm_type VARCHAR(10),
    sanct_lim DECIMAL(15,2),
    acct_crncy_code VARCHAR(5),
    del_flg CHAR(1),
    acct_cls_flg CHAR(1),
    drwng_power DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    accrued_interest DECIMAL(15,2),
    limit_b2kid VARCHAR(20),
    clr_bal_amt DECIMAL(15,2),
    FOREIGN KEY (cif_id) REFERENCES customers(cif_id),
    FOREIGN KEY (product_schm_code) REFERENCES products(product_scheme_code)
);

CREATE TABLE cards (
    card_number VARCHAR(30) PRIMARY KEY,
    account_number VARCHAR(30),
    aty_code INT,
    card_status CHAR(1),
    foracid VARCHAR(30),
    car_code BIGINT,
    product_code VARCHAR(20),
    acc_paym_mode DECIMAL(10,2),
    credit_limit DECIMAL(15,2),
    car_create_date DATE,
    FOREIGN KEY (foracid) REFERENCES accounts(foracid),
    FOREIGN KEY (account_number) REFERENCES accounts.foracid
);

CREATE TABLE transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    transaction_key VARCHAR(50),
    foracid VARCHAR(30),
    transaction_amount DECIMAL(15, 2),
    amount_left DECIMAL(15, 2),
    p_tran_type CHAR(1), -- C for Credit, D for Debit
    digital_flag CHAR(1), -- Y/N
    transaction_channel_type VARCHAR(50),
    timestamp TIMESTAMP,
    FOREIGN KEY (foracid) REFERENCES accounts(foracid)
);

CREATE TABLE staging.customers AS TABLE raw.customers WITH NO DATA;
CREATE TABLE staging.products AS TABLE raw.products WITH NO DATA;
CREATE TABLE staging.accounts AS TABLE raw.accounts WITH NO DATA;
CREATE TABLE staging.cards AS TABLE raw.cards WITH NO DATA;
CREATE TABLE staging.transactions AS TABLE raw.transactions WITH NO DATA;
