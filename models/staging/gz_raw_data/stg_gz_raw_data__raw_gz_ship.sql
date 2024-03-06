with 

source as (

    select * from {{ source('gz_raw_data', 'raw_gz_ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
     --   shipping_fee_1,
        logcost,
        ship_cost

    from source
    --Where shipping_fee != shipping_fee_1

)

select * from renamed
