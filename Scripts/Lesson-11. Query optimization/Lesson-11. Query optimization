use shop;

-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
-- в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at TIMESTAMP NOT NULL,
	table_name VARCHAR(50) NOT NULL,
	pk_id BIGINT(50) NOT NULL,
	name VARCHAR(50)
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS log_users;
delimiter //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs
	VALUES (CURRENT_TIMESTAMP, 'users', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS log_catalogs;
delimiter //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs
	VALUES (CURRENT_TIMESTAMP, 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS log_products;
delimiter //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs
	VALUES (CURRENT_TIMESTAMP, 'products', NEW.id, NEW.name);
END //
delimiter ;


-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
START TRANSACTION
	DECLARE i INT DEFAULT 100;
	DECLARE j INT DEFAULT 1;
	WHILE i>0 DO
		INSERT INTO users (name)
		VALUES (CONCAT('user_',j));
		SET i=i-1;
		SET j=J+1;
	END WHILE;
COMMIT
