
UPDATE car_service AS cs
SET payment = cs1.payment
FROM (
    SELECT DISTINCT card, payment
    FROM car_service
    WHERE card IS NOT NULL AND payment IS NOT NULL
) AS cs1
WHERE cs.card = cs1.card;


UPDATE car_service AS cs
SET pin = cs1.pin
FROM (
    SELECT DISTINCT card, pin
    FROM car_service
    WHERE card IS NOT NULL AND pin IS NOT NULL
) AS cs1
WHERE cs.card = cs1.card;


UPDATE car_service AS cs
SET card = cs1.card
FROM (
    SELECT DISTINCT card, pin
    FROM car_service
    WHERE card IS NOT NULL AND pin IS NOT NULL
) AS cs1
WHERE cs.pin = cs1.pin;


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    date DATE,
    service_id INTEGER,
    worker_id INTEGER,
    card TEXT,
    payment TEXT,
    pin TEXT,
    client_id INTEGER,
    car_id INTEGER,
    mileage TEXT
);


INSERT INTO orders (
    date,
    service_id,
    worker_id,
    card,
    payment,
    pin,
    client_id,
    car_id,
    mileage
)
SELECT
    date,
    s.service_id,
    w.worker_id,
    card,
    payment,
    pin,
    cl.client_id,
    c.car_id,
    mileage
FROM car_service cs
JOIN cars c USING (vin)
JOIN clients cl USING (phone)
JOIN services s USING (service, service_addr)
JOIN workers w ON cs.w_phone = w.phone;

ALTER TABLE orders
ADD CONSTRAINT fk_service
FOREIGN KEY (service_id) REFERENCES services(service_id),
ADD CONSTRAINT fk_worker
FOREIGN KEY (worker_id) REFERENCES workers(worker_id),
ADD CONSTRAINT fk_client
FOREIGN KEY (client_id) REFERENCES clients(client_id),
ADD CONSTRAINT fk_car
FOREIGN KEY (car_id) REFERENCES cars(car_id);


CREATE INDEX orders_date_idx ON orders(date);


ALTER TABLE orders
ALTER COLUMN payment TYPE INTEGER USING payment::INTEGER;

SELECT COUNT(*) FROM orders o ;