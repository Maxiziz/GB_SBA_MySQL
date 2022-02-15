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
GROUP BY c.name
ORDER BY docs_qty DESC;


-- представления (минимум 2)

-- 1. Вывод списка документов поставщиков отдела маркетинга.

-- 2. Вывод всех неподписанных договоров со статусом ("Проект").


-- Хранимая процедура / функция / триггер (на выбор, 1 шт.);

-- 1. Процедура по удалению документов старше 3х лет

-- 2. Функция по выводу списка документов по вводимому городу.

