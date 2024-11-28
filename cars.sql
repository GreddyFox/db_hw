UPDATE car_service AS cs
SET car = cs1.car
FROM (
    SELECT DISTINCT
        car,
        vin
    FROM car_service
    WHERE
        car IS NOT NULL AND
        vin IS NOT NULL
) AS cs1
WHERE cs.vin = cs1.vin;



UPDATE car_service AS cs
SET car_number = cs1.car_number
FROM (
    SELECT DISTINCT
        car_number,
        vin
    FROM car_service
    WHERE
        car_number IS NOT NULL AND
        vin IS NOT NULL
) AS cs1
WHERE cs.vin = cs1.vin;


UPDATE car_service AS cs
SET color = cs1.color
FROM (
    SELECT DISTINCT
        color,
        vin
    FROM car_service
    WHERE
        color IS NOT NULL AND
        vin IS NOT NULL
) AS cs1
WHERE cs.vin = cs1.vin;


UPDATE car_service AS cs
SET vin = cs1.vin
FROM (
    SELECT DISTINCT
        car_number,
        car,
        color,
        vin
    FROM car_service
    WHERE
        car IS NOT NULL AND
        car_number IS NOT NULL AND
        color IS NOT NULL AND
        vin IS NOT NULL
) AS cs1
WHERE
    cs.car_number = cs1.car_number AND
    cs.car = cs1.car AND
    cs.color = cs1.color;

   
CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    vin TEXT,
    car TEXT,
    car_number TEXT,
    color TEXT
);

INSERT INTO cars(vin, car, car_number, color)
SELECT DISTINCT
    vin,
    car,
    car_number,
    color
FROM car_service;

SELECT COUNT(*) FROM cars;

