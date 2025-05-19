from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'start_date': datetime(2025, 5, 1)
}

with DAG(
    dag_id='banking_data_ingestion',
    default_args=default_args,
    description='Ingest raw banking data into staging schema',
    catchup=False
) as dag:

    def copy_table(src_table, dest_table):
        pg_hook = PostgresHook(postgres_conn_id='postgres_default')
        sql = f'TRUNCATE staging.{dest_table}; INSERT INTO staging.{dest_table} SELECT * FROM raw.{src_table};'
        pg_hook.run(sql)
        print(f"Data copied from raw.{src_table} to staging.{dest_table}")

    table_mappings = [
        ('transaction', 'transaction'),
        ('account', 'account'),
        ('customer', 'customer'),
        ('cards', 'cards'),
        ('product', 'product')
    ]

tasks = []
for src, dest in table_mappings:
    task = PythonOperator(
        task_id=f'copy_{src}_to_staging',
        python_callable=copy_table,
        op_args=[src, dest]
    )
    tasks.append(task)
