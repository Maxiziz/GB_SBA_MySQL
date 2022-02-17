use crm;

-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные запросы)

-- 1. Вывести все компании, закрепленные за сотрудниками отдела IT(не зная его id в БД).

SELECT s.name supplier, c.name concern, r.name region, sp.name sphere, e.name responsible_employee
FROM employees e
JOIN suppliers s ON s.responsible_id=e.id -- JOIN, подставим компании
JOIN concerns c ON s.concern_id=c.id -- JOIN, подставим названия концернов
JOIN regions r ON s.region_id=r.id -- JOIN, подставим названия регионов
JOIN spheres sp ON s.sphere_id=sp.id -- JOIN, подставим названия сферы компании
WHERE department_id =
	(SELECT d.id FROM departments d WHERE name='IT'); -- вложенный запрос
	

-- 2. Вывести кол-ва документов(файлов) по группам компаний (концернам)
	
SELECT c.name concern,
CASE
	WHEN count(d.id)=0 then 0
	ELSE count(d.id)
END AS docs_qty
FROM concerns c
LEFT JOIN suppliers s ON s.concern_id=c.id -- LEFT JOIN позволит увидеть, если к концерну не относится ни одного документа
LEFT JOIN documents d ON d.supplier_id=s.id 
GROUP BY c.name -- группировка
ORDER BY docs_qty DESC; -- соритровка


-- представления (минимум 2)

-- 1. Вывод списка документов поставщиков отдела маркетинга

-- за основу возьмем схожую выборку, оставим информацию по поставщику и добавим договоры
CREATE OR REPLACE VIEW marketing_contracts AS
SELECT d.id document_id, d.filename, st.name `status`, dt.name doc_type, s.name supplier, c.name concern, r.name region, sp.name sphere, e.name responsible_employee, d.updated_at
FROM employees e
JOIN suppliers s ON s.responsible_id=e.id
JOIN documents d ON d.supplier_id=s.id
JOIN statuses st ON d.status_id=st.id 
JOIN doc_types dt ON d.doc_type_id=dt.id 
JOIN concerns c ON s.concern_id=c.id
JOIN regions r ON s.region_id=r.id
JOIN spheres sp ON s.sphere_id=sp.id
WHERE department_id =
	(SELECT d.id FROM departments d WHERE name='MARKETING')
ORDER BY d.updated_at DESC; -- updated_at не заполнена в тестовой базе, но задумка хорошая
-- SELECT * FROM marketing_contracts;

-- 2. Вывод всех неподписанных доп.соглашений со статусом "Проект".
CREATE OR REPLACE VIEW supp_agr_projects AS
SELECT d.id, d.filename, d.description, d.`size`, s.name supplier, st.name `status`, dt.name doc_type, d.created_at 
FROM documents d
JOIN statuses st ON d.status_id=st.id
JOIN doc_types dt ON d.doc_type_id=dt.id
JOIN suppliers s ON d.supplier_id=s.id
WHERE status_id=3 AND doc_type_id=2
ORDER BY d.created_at ASC; -- здесь уже сделаем по дате создания и по взрастанию, т.к. интересный в первую очередь самые давние незавершенные проекты 
SELECT * FROM supp_agr_projects;

-- Хранимая процедура / функция / триггер (на выбор, 1 шт.);

-- 1. Процедура по удалению проектов документов старше 31 дней
-- Плюс добавим транзакционность и возврат информации об ошибке.
DROP PROCEDURE IF EXISTS pr_delete_old_projects;

DELIMITER //
CREATE PROCEDURE pr_delete_old_projects (OUT tran_result varchar(100))
BEGIN
	DECLARE `rollback` BOOL DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET `rollback` = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string=MESSAGE_TEXT;
		SET tran_result := CONCAT('Error occured. Code: ', code, '. Text: ', error_string);
	END
	
	DECLARE `qty` BIGINT(100) UNSIGNED;
	START TRANSACTION;

	DELETE FROM documents WHERE DATEDIFF(CURRENT_DATE() ,created_at)>31 and status_id=3;

	IF `_rollback` THEN
	    	ROLLBACK;
	    ELSE
		set tran_result := 'ok';
	    	COMMIT;
	END IF;
END//
DELIMITER ;

-- 2. Функция по выводу кол-ва документов по вводимому региону.
DROP FUNCTION IF EXISTS func_region_documents;

DELIMITER //
CREATE FUNCTION func_region_documents(check_region_id BIGINT(10) UNSIGNED)
RETURNS INT UNSIGNED READS SQL DATA
	BEGIN
		DECLARE `_result` INT;
		SET `_result` = (
		SELECT COUNT(*)
		FROM documents d
		JOIN suppliers s ON d.supplier_id=s.id 
		WHERE s.region_id=check_region_id);
	
		RETURN `_result`;
	END//
DELIMITER ;
-- SELECT func_region_documents (3);

