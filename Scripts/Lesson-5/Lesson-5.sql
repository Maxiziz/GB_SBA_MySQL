-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE `users` SET created_at=NOW(), updated_at=NOW();

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
/*DROP TABLE IF EXISTS `test1`;
CREATE TABLE test1 (
	id SERIAL,
	created_at VARCHAR(100),
	updated_at VARCHAR(100)	
);
INSERT test1 SET created_at='20.10.2017 8:10', updated_at='20.10.2017 16:10';*/
-- Чтобы не портить таблицу users, вместо неё использую таблицу test1
ALTER TABLE test1 
ADD COLUMN created_at_2 DATETIME,
ADD COLUMN updated_at_2 DATETIME;
UPDATE test1 SET 
created_at_2=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), 
updated_at_2=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
 * если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.*/
-- Чтобы не портить таблицу users, вместо неё использую таблицу test1
/*
DROP TABLE IF EXISTS `test1`;
CREATE TABLE `test1` (
	id SERIAL,
	value INT UNSIGNED NOT NULL DEFAULT 0
);
INSERT INTO test1 (value) VALUES (0),(2500),(0),(30),(500),(1);
*/
SELECT value from test1 ORDER BY value = 0, value;

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august').
-- Вопрос: Может не "заданы", а "вывести"?
SELECT name, birthday_at, MONTHNAME(birthday_at) from users where MONTHNAME(birthday_at) IN ('May', 'August');


-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM catalogs WHERE id IN (5,1,2)
ORDER BY FIELD(id,5, 1, 2);

-- Практическое задание теме “Агрегация данных”
-- 1. Подсчитайте средний возраст пользователей в таблице users
/*
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Gennadiy', '1990-10-05'),
  ('Natalya', '1984-11-12'),
  ('Alexandr', '1985-05-20'),
  ('Sergey', '1988-02-14'),
  ('Ivan', '1998-01-12'),
  ('Mariya', '1992-08-29');
*/
  
 SELECT ROUND(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25)) as av_age from users;
 
-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
-- SELECT id, DATE_FORMAT(birthday_at, '2021-%m-%d'), WEEKDAY(DATE_FORMAT(birthday_at, '2021-%m-%d') from users;
SELECT 
ELT(WEEKDAY(DATE_FORMAT(birthday_at, '2021-%m-%d'))+1, 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun') AS `weekday`,
COUNT(*) as `birthdays_qty`
FROM users
GROUP BY ELT(WEEKDAY(DATE_FORMAT(birthday_at, '2021-%m-%d'))+1, 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')
ORDER BY FIELD(`weekday`,'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
