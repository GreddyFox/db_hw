UPDATE car_service AS cs
SET w_name = cs1.w_name
FROM (
    SELECT DISTINCT w_name, w_phone
    FROM car_service
    WHERE w_name IS NOT NULL AND w_phone IS NOT NULL
) AS cs1
WHERE cs.w_phone = cs1.w_phone;


UPDATE car_service AS cs
SET w_exp = cs1.w_exp
FROM (
    SELECT DISTINCT w_exp, w_phone
    FROM car_service
    WHERE w_phone IS NOT NULL AND w_exp IS NOT NULL
) AS cs1
WHERE cs.w_phone = cs1.w_phone;


UPDATE car_service AS cs
SET wages = cs1.wages
FROM (
    SELECT DISTINCT wages, w_phone
    FROM car_service
    WHERE w_phone IS NOT NULL AND wages IS NOT NULL
) AS cs1
WHERE cs.w_phone = cs1.w_phone;


UPDATE car_service AS cs
SET w_phone = cs1.w_phone
FROM (
    SELECT DISTINCT wages, w_phone, w_name, w_exp
    FROM car_service
    WHERE w_name IS NOT NULL AND w_exp IS NOT NULL AND wages IS NOT NULL AND w_phone IS NOT NULL
) AS cs1
WHERE cs.w_name = cs1.w_name AND cs.w_exp = cs1.w_exp AND cs.wages = cs1.wages;


CREATE TABLE workers (
    worker_id SERIAL PRIMARY KEY,
    phone TEXT,
    first_name TEXT,
    last_name TEXT,
    exp INTEGER,
    wages INTEGER
);


INSERT INTO workers(phone, first_name, last_name, exp, wages)
SELECT DISTINCT 
    w_phone AS phone,
    SPLIT_PART(w_name, ' ', 1) AS first_name,
    SPLIT_PART(w_name, ' ', 2) AS last_name,
    w_exp::INTEGER AS exp,
    wages::INTEGER AS wages
FROM car_service;

SELECT COUNT(*) FROM workers w ;
