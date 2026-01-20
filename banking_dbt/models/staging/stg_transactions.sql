{{ config( materialized='view') }}

SELECT 
    v:id::string                    as transaction_id, 
    v:account_id::string            as account_id, 
    v:amount::float                 as amount, 
    v:txn_type::string              as transaction_type, 
    v:related_account_id::string    as related_account_id,
    v:status::string                as status, 
    v:created_at::timestamp         as transaction_time, 
    CURRENT_TIMESTAMP               as load_timestamp
FROM {{ source('raw','transactions') }}