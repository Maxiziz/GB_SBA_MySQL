use crm;

-- добавим индекс для соответствия курсового проекта требованиям
ALTER TABLE suppliers
ADD INDEX sup_name (name); -- предусмотрим, что будут часто искать по названию компании.

ALTER TABLE documents
ADD INDEX doc_filename (filename); -- предусмотрим, что документы будут часто искать по названию файла

-- добавим ещё 10 договоров 
INSERT INTO documents (`filename`,`description`,`size`,`status_id`,`doc_type_id`,`supplier_id`) VALUES
  ("elementum, lorem ut","et tristique pellentesque, tellus sem",4239,1,4,7),
  ("erat vel","vel turpis. Aliquam adipiscing",8459,2,2,7),
  ("eget laoreet","tincidunt adipiscing. Mauris molestie pharetra",5194,3,3,9),
  ("cursus","lacinia mattis. Integer eu lacus. Quisque imperdiet,",7077,2,2,7),
  ("justo. Proin non","amet, consectetuer adipiscing elit. Etiam laoreet, libero",9643,3,2,5),
  ("elementum, dui","tempus non,",9828,3,2,9),
  ("nulla","aliquet, metus urna convallis erat,",3996,3,2,1),
  ("cursus. Nunc mauris","Nam tempor diam dictum",3498,2,1,4),
  ("Donec dignissim","rhoncus. Nullam velit dui, semper et,",2440,1,3,7),
  ("porttitor scelerisque neque.","risus.",7306,3,3,3);