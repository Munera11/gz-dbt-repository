WITH joined_data AS (
    SELECT
        o_margin.*,
        ship.shipping_fee,
        ship.logcost,
        ship.ship_cost,
        ship.orders_id
    FROM
        {{ ref('int_orders_margin') }} AS o_margin
    INNER JOIN
        {{ ref('stg_gz_raw_data__raw_gz_ship') }} AS ship
    ON o_margin.orders_id = ship.orders_id
    
)
SELECT
    *,
    ROUND(CAST(margin AS FLOAT64) + CAST(shipping_fee AS FLOAT64) - CAST(logcost AS FLOAT64) - CAST(ship_cost AS FLOAT64),2) AS operational_margin
FROM
    joined_data
    

SELECT
  o_margin.*,
  ,ROUND(o_margin.margin + s.shipping_fee - (s.logcost + s.ship_cost),2) AS operational_margin 
  ,s.shipping_fee
  ,s.logcost
  ,s.ship_cost
FROM {{ ref('int_orders_margin') }} o_margin
LEFT JOIN {{ ref('stg_gz_raw_data__raw_gz_ship') }} s 
  USING(orders_id)
ORDER BY orders_id desc
    
