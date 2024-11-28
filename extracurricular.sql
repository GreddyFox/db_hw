-- 1)Создать таблицу скидок и дать скидку самым частым клиентам
CREATE TABLE discounts (
    discount_id SERIAL PRIMARY KEY,
    client_id INTEGER,
    discount_percentage DECIMAL(4, 2),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

INSERT INTO discounts (client_id, discount_percentage)
SELECT
    client_id,
    10.00
FROM
    (
        SELECT client_id, COUNT(order_id) as order_count
        FROM orders
        GROUP BY client_id
        ORDER BY order_count DESC
        LIMIT 10 
    );

  SELECT * FROM discounts d 
  
  
  
-- 2) Поднять зарплату трем самым результативным механикам на 10%
UPDATE workers
SET wages = wages * 1.10
WHERE 
    worker_id 
IN (
    SELECT worker_id
    FROM orders
    GROUP BY worker_id
    ORDER BY COUNT(order_id) DESC
    LIMIT 3
);

-- 3) Сделать представление для директора: филиал, количество заказов за последний месяц, заработанная сумма, заработанная сумма за вычетом зарплаты
CREATE VIEW monthly_service_report AS
SELECT 
    s.service,
    s.service_addr,
    COUNT(o.order_id) AS order_count,
    SUM(o.payment) AS income,
    SUM(o.payment) - SUM(w.wages) AS profit
FROM 
    orders o
JOIN 
    services s USING(service_id)
JOIN 
    workers w USING(worker_id)
WHERE 
    o.date >= (SELECT MAX(date) FROM orders) - INTERVAL '1 month'
    AND o.date < (SELECT MAX(date) FROM orders) and payment IS NOT NULL
GROUP BY 
 	s.service, s.service_addr;
 	
 SELECT * FROM monthly_service_report;


-- 4) Сделать рейтинг самых надежных и ненадежных авто
SELECT
    c.car,
    COUNT(o.car_id) AS repair_count,
    SUM(o.payment) AS total_repair_cost
FROM
    cars c
JOIN
    orders o USING(car_id)
WHERE 
    payment IS NOT NULL
GROUP BY
    c.car
ORDER BY
    repair_count ASC, 
    total_repair_cost ASC; 

 