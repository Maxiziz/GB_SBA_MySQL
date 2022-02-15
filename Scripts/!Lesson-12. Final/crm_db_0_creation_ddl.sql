DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm;
USE crm;

DROP TABLE IF EXISTS regions;
CREATE TABLE regions (
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'Регионы компаний';

DROP TABLE IF EXISTS spheres;
CREATE TABLE spheres (
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'Сферы деятельности компаний';

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'Отделы';

DROP TABLE IF EXISTS statuses;
CREATE TABLE statuses (
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'Статусы документов';

DROP TABLE IF EXISTS doc_types;
CREATE TABLE doc_types (
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'Типы документов';

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	gender CHAR(1),
	supervisor BIGINT(10) UNSIGNED NOT NULL, -- Этот столбец должен принадлежать к тому же типу данных, что и столбец, для которого определяется ограничение
	department_id BIGINT(10) UNSIGNED NOT NULL,
	FOREIGN KEY supervisor_id (supervisor) REFERENCES employees(id), -- Ограничения FOREIGN KEY могут ссылаться на другие столбцы той же таблицы и считаются ссылками на себя
	FOREIGN KEY (department_id) REFERENCES departments(id)
);

DROP TABLE IF EXISTS concerns;
CREATE TABLE concerns (
	id SERIAL,
	name VARCHAR(50)
) COMMENT 'Группы поставщиков';

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers (
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	responsible_id BIGINT(10) UNSIGNED NOT NULL,
	concern_id BIGINT(10) UNSIGNED NOT NULL,
	region_id BIGINT(10) UNSIGNED NOT NULL,
	sphere_id BIGINT(10) UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY responsible_employee_id (responsible_id) REFERENCES employees(id),
	FOREIGN KEY concern_id (concern_id) REFERENCES concerns(id),
	FOREIGN KEY region_id (region_id) REFERENCES regions(id),
	FOREIGN KEY sphere_id (sphere_id) REFERENCES spheres(id)
) COMMENT 'Поставщики';

DROP TABLE IF EXISTS sup_contact_info;
CREATE TABLE sup_contact_info (
	sup_id BIGINT UNSIGNED NOT NULL UNIQUE,
	phone VARCHAR(50),
	yur_adress VARCHAR(200),
	fiz_adress VARCHAR(200),
	INN VARCHAR(20),
	KPP VARCHAR(20),
	
	FOREIGN KEY sup_id (sup_id) REFERENCES suppliers(id)
) COMMENT 'Контактная информация поставщиков';

DROP TABLE IF EXISTS documents;
CREATE TABLE documents (
	id SERIAL,
	filename VARCHAR(200),
	description text,
	size INT,
	status_id BIGINT(10) UNSIGNED NOT NULL,
	doc_type_id BIGINT(10) UNSIGNED NOT NULL,
	supplier_id BIGINT(10) UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX documents_name(filename),
	FOREIGN KEY status_id (status_id) REFERENCES statuses (id),
	FOREIGN KEY doc_type_id (doc_type_id) REFERENCES doc_types(id),
	FOREIGN KEY supplier_id (supplier_id) REFERENCES suppliers(id)
) COMMENT 'Документы поставщиков';
