-- Практическое задание. Урок 7 "Сложные запросы"
-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
/*INSERT orders (user_id) VALUES (2),(4),(5);*/ -- добавил для теста заказы для пользователей 2,4,5

SELECT * FROM users WHERE EXISTS (SELECT * FROM orders WHERE user_id=users.id);


-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
-- Вариант 1. Через объединение таблиц
SELECT p.id, p.name, /*description, price, catalog_id,*/ c.name catalog_name FROM products p, catalogs c WHERE c.id=p.catalog_id;

-- Вариант 2. Через вложенный запрос, тоже вроде как объединение происходит
SELECT p.id, p.name,
(SELECT c.name FROM catalogs c WHERE c.id=p.catalog_id) as 'catalog_name'
FROM products p;

-- Вариант 3. Через JOIN
SELECT p.id, p.name, c.name catalog_name
FROM products p
JOIN catalogs c
ON c.id=p.catalog_id;


-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to)
-- и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- Внесу таблицы для тестирования 
/*DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
id SERIAL,
`from` VARCHAR(10),
`to` VARCHAR(10)
);

INSERT INTO flights (`from`,`to`) VALUES
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
label VARCHAR(10),
name VARCHAR(15)
);
INSERT INTO cities VALUES 
('moscow','RU_Moskwa'),
('irkutsk','RU_Irkutsk'),
('novgorod','RU_Novgorod'),
('kazan','RU_Kazan\''),
('omsk','RU_Omsk');
*/
-- ----------- 
-- Вариант 1
SELECT f.id, c1.name from_ru, c2.name to_ru FROM flights f
JOIN cities c1 ON f.`from`=c1.label
JOIN cities c2 ON f.`to`=c2.label
ORDER BY id; -- не понял, как он сортирует без ORDER BY, почему-то как-то произвольно....

-- Вариант 2
SELECT f.id,
(SELECT c.name FROM cities c WHERE f.`from`=c.label) as 'from_ru',
(SELECT c.name FROM cities c WHERE f.`to`=c.label) as 'to_ru'
FROM flights f;
