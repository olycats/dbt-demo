with source as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from {{ source('jaffle_shop', 'orders') }}
),

order_status_mapping as (select * from {{ ref('seed_order_statuses') }}),

transformed as (
    select
        t0.order_id,
        t0.customer_id,
        t0.order_date,
        t0.status,
        t1.is_valid
    from source as t0
    left join order_status_mapping as t1 on t0.status = t1.status
)

select * from transformed