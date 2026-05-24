{{
    config (
      engine='MergeTree()',
      order_by=['O_ORDERYEAR', 'O_ORDERSTATUS', 'O_ORDERPRIORITY']
    )
}}

SELECT
    toYear(o.O_ORDERDATE) AS O_ORDERYEAR,
    o.O_ORDERSTATUS AS O_ORDERSTATUS,
    o.O_ORDERPRIORITY AS O_ORDERPRIORITY,
    count(DISTINCT o.O_ORDERKEY) AS num_orders,
    count(DISTINCT c.C_CUSTKEY) AS num_customers,
    sum(l.L_EXTENDEDPRICE * l.L_DISCOUNT) AS revenue
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_customer') }} c ON o.O_CUSTKEY = c.C_CUSTKEY
LEFT JOIN {{ ref('stg_lineitem') }} l ON o.O_ORDERKEY = l.L_ORDERKEY
GROUP BY
    O_ORDERYEAR,
    O_ORDERSTATUS,
    O_ORDERPRIORITY