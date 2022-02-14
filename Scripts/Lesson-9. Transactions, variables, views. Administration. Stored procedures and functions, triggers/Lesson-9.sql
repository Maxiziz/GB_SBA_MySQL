-- “Транзакции, переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
-- Используйте транзакции.
START TRANSACTION;

-- один из вариантов решений, на случай, если таблица, куда перемещаем, - не пустая, как и в моем случае.
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

DELETE FROM shop.users WHERE id=1 LIMIT 1;

SELECT * from sample.users;
SELECT * from shop.users;

COMMIT;

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW name_catalog AS
SELECT p.name, c.name as catalog_name
FROM products p
LEFT JOIN catalogs c ON p.catalog_id = c.id;
SELECT * FROM name_catalog ;


-- (по желанию) Пусть имеется таблица с календарным полем created_at. 
-- В ней размещены разряженые календарные записи за август 2018 года 
-- '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
-- если дата присутствует в исходном таблице и 0, если она отсутствует.

DROP TABLE IF EXISTS dates;
CREATE TABLE IF NOT EXISTS dates (
created_at DATE
);
INSERT INTO dates VALUES
('2018-08-01'),
('2018-08-04'),
('2018-08-16'),
('2018-08-17');

-- из разбора вариант с лютой штукой(для вывода всех дат в интервале дат) из гугла решил не использовать
CREATE TEMPORARY TABLE last_days (
day INT
);

INSERT INTO last_days VALUES 
(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30);

SELECT DATE(DATE('2018-08-31') - INTERVAL l.day DAY) as `day`
FROM last_days AS l
ORDER BY `day`; 

SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) as `day`,
	NOT ISNULL(d.created_at) AS order_exists
FROM
	last_days AS l
LEFT JOIN 
	dates AS d
ON DATE(DATE('2018-08-31') - INTERVAL l.day DAY) = d.created_at
ORDER BY `day`;

-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

CREATE OR REPLACE VIEW last5 AS
SELECT * FROM datetbl ORDER BY created_at DESC LIMIT 5;
SELECT * FROM last5 ;
DELETE * FROM datetbl WHERE created_at < ALL(SELECT * FROM last5);

-- вариант из разбора
START TRANSACTION;

PREPARE postdel FROM 'DELETE FROM dates ORDER BY created_at LIMIT ?';

SET @total = (SELECT COUNT(*) - 5 FROM posts);

EXECUTE postdel USING @total;


-- Администрирование MySQL
-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

CREATE USER 'shop_read'@'localhost'; -- доступ только с локальной машины
GRANT SELECT, SHOW VIEW ON shop.* TO 'shop_read'@'localhost' IDENTIFIED BY '';

CREATE USER 'shop'@'localhost';
GRANT ALL ON shop.* TO 'shop'@'localhost' IDENTIFIED BY '';

-- 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ,
-- имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name.
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

CREATE OR REPLACE VIEW username AS SELECT id, name FROM accounts;

CREATE USER 'user_read'@'localhost';
GRANT SELECT (id, name) ON shop.username TO 'user_read'@'localhost';


-- Хранимые процедуры и функции, триггеры
-- 1. Создайте хранимую функцию hello(),
-- которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

SELECT HOUR(NOW());

DELIMITER //
CREATE FUNCTION get_hour ()
RETURNS INT NOT DETERMINISTIC
BEGIN
	RETURN HOUR(NOW());
END//
DELIMITER ; -- просто так привычней

SELECT get_hour();

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT NOT DETERMINISTIC 
BEGIN 
	DECLARE hour INT;
	SET `hour` = HOUR(NOW());
	CASE
		WHEN `hour` BETWEEN 0 AND 5 THEN 
			RETURN 'Good night';
		WHEN `hour` BETWEEN 6 AND 11 THEN 
			RETURN 'Good morning';
		WHEN `hour` BETWEEN 12 AND 17 THEN
			RETURN 'Good day';
		WHEN `hour` BETWEEN 18 AND 23 THEN 
			RETURN 'Good evening';
	END CASE;		
END//
DELIMITER ;

SELECT NOW(), hello ();

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //
CREATE TRIGGER validate_name_description_insert BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Both name and description are NULL';
	END IF;
END//

CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Both name and description are NULL';
	END IF;
END//
DELIMITER ;

-- проверить
INSERT INTO products 
(name, description,price,catalog_id) VALUES 
(NULL,NULL,1000,1);


-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

-- Чтобы избежать рекурсии, взять аналитическое решение - формула Бине.

DELIMITER //
CREATE FUNCTION FIBONACCI(num INT)
RETURNS INT DETERMINISTIC 
BEGIN
	DECLARE fs DOUBLE; -- заменить SQRT(5)
	SET fs = SQRT(5);
	
	RETURN (POW ((1+fs) /2, num) + POW((1-fs) /2 ,num)) / fs;
END //
DELIMITER ;

SELECT FIBONACCI (10);