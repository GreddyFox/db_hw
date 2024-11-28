CREATE TABLE car_service (
    date DATE,
    service TEXT,
    service_addr TEXT,
    w_name TEXT,
    w_exp TEXT,
    w_phone TEXT,
    wages INTEGER,
    card TEXT,
    payment TEXT,
    pin TEXT,
    name TEXT,
    phone TEXT,
    email TEXT,
    password TEXT,
    car TEXT,
    mileage INTEGER,
    vin TEXT,
    car_number TEXT,
    color TEXT
);

SELECT * FROM car_service LIMIT 5;
SELECT COUNT(*) FROM car_service;