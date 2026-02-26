-- =====================================================
-- Hive Telecom Case Study
-- Partitioning + Bucketing + ORC Optimization
-- =====================================================

-- ================================
-- 1. Create External Raw Tables
-- ================================

CREATE EXTERNAL TABLE call_data_raw (
    call_id INT,
    customer_id INT,
    call_duration FLOAT,
    region STRING,
    call_date STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/hive/warehouse/telecom/call_data';

CREATE EXTERNAL TABLE data_usage_raw (
    usage_id INT,
    customer_id INT,
    data_used FLOAT,
    region STRING,
    usage_date STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/hive/warehouse/telecom/data_usage';

CREATE EXTERNAL TABLE sms_data_raw (
    sms_id INT,
    customer_id INT,
    sms_count INT,
    region STRING,
    sms_date STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/hive/warehouse/telecom/sms_data';


-- =========================================
-- 2. Create Managed ORC Optimized Tables
-- =========================================

CREATE TABLE call_data_managed (
    call_id INT,
    customer_id INT,
    call_duration FLOAT
)
PARTITIONED BY (call_date STRING, region STRING)
CLUSTERED BY (customer_id) INTO 10 BUCKETS
STORED AS ORC;

SET hive.enforce.bucketing = true;

INSERT OVERWRITE TABLE call_data_managed
PARTITION (call_date, region)
SELECT call_id, customer_id, call_duration, call_date, region
FROM call_data_raw;


-- =========================================
-- 3. Optimization Queries
-- =========================================

-- Total call duration by date & region
SELECT SUM(call_duration) AS total_duration
FROM call_data_managed
WHERE call_date = '2023-08-01'
AND region = 'North';

-- Top data users by region
SELECT customer_id, SUM(data_used) AS total_data
FROM data_usage_raw
WHERE region = 'North'
GROUP BY customer_id
ORDER BY total_data DESC;

-- SMS usage trend
SELECT customer_id, SUM(sms_count) AS total_sms
FROM sms_data_raw
WHERE region = 'North'
GROUP BY customer_id;
