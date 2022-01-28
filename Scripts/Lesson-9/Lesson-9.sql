-- “Транзакции, переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
-- Используйте транзакции.
START TRANSACTION;
-- use shop;

DROP TEMPORARY TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1 
SELECT * FROM shop.users u
WHERE u.id=1;
ALTER TABLE tmp1 DROP id;

-- SELECT * from tmp1;
-- use sample;
INSERT sample.users
SELECT 0,tmp1.* FROM tmp1;
DROP TABLE tmp1;

SELECT * from sample.users;

COMMIT;

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW name_catalog AS
SELECT p.name, c.name as catalog_name
FROM products p
LEFT JOIN catalogs c ON p.catalog_id = c.id;
SELECT * FROM name_catalog ;

-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

CREATE VIEW last5 AS
SELECT * FROM datetbl ORDER BY created_at DESC LIMIT 5;
SELECT * FROM last5 ;
DELETE * FROM datetbl WHERE created_at < ALL(SELECT * FROM last5);
