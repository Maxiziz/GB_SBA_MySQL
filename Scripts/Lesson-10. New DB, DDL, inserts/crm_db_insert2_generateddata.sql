use crm;

INSERT departments (name)
VALUES 
	("Head"),
	("IT"),
	("Marketing"),
	("Sales"),
	("Legal"),
	("Technical"),
	("HR");

INSERT INTO `employees` (`name`,`gender`,`supervisor`,department_id)
VALUES
  ("Xander Kerr","m",1,1),
  ("Kathleen Kane","f",1,2),
  ("Zelda Lynn","f",1,3);

INSERT INTO `employees` (`name`,`gender`,`supervisor`,department_id)
VALUES
  ("Xena Gilliam","f",3,3),
  ("Benjamin Haley","m",1,4),
  ("Faith Bryant","f",3,3),
  ("Colt Roy","m",1,6),
  ("Courtney Moore","f",1,7),
  ("Lane Barton","m",2,2),
  ("Judah Wolfe","m",3,3);
  
INSERT INTO concerns (name) VALUES
	("Non Dapibus Rutrum Corp."),
	("Nibh Foundation"),
	("Blandit Institute"),
	("Ullamcorper Velit Industries"),
	("Tellus Foundation");

INSERT INTO suppliers (name, responsible_id, concern_id, region_id, sphere_id) VALUES
  ("Non Dapibus Rutrum Corp.",6,2,2,6),
  ("Nibh Foundation",5,3,3,7),
  ("Blandit Institute",5,2,5,5),
  ("Ullamcorper Velit Industries",10,4,4,7),
  ("Tellus Foundation",6,2,2,1),
  ("Nec Luctus Felis Ltd",8,4,2,3),
  ("Dui LLC",4,3,3,2),
  ("Donec Nibh Enim PC",8,1,3,3),
  ("Donec Inc.",5,1,2,6),
  ("Fermentum Risus Corp.",9,4,6,4);

INSERT INTO sup_contact_info (`sup_id`,`phone`,`yur_adress`,`fiz_adress`,`INN`,`KPP`) VALUES
  (1,"+7 (495) 277-19-11","901-5514 Nec Road","Ap #517-9267 Placerat Av.","79745597021","68154485264"),
  (2,"+7 (495) 419-31-08","563-2700 Donec St.","7114 Eget Street","81492316457","73618075214"),
  (3,"+7 (495) 008-11-83","P.O. Box 338, 6517 A Rd.","P.O. Box 540, 7019 Per St.","84858102343","27640181565"),
  (4,"+7 (495) 372-58-03","7585 Gravida St.","Ap #711-8170 Suspendisse Rd.","19368324816","64452793976"),
  (5,"+7 (495) 296-81-78","Ap #546-5580 Aliquam Road","Ap #285-6837 Facilisi. Ave","25975435861","98880480441"),
  (6,"+7 (495) 342-31-79","Ap #886-686 Lacus. Ave","P.O. Box 573, 3790 Aliquam Road","98817987345","69185635492"),
  (7,"+7 (495) 329-06-86","P.O. Box 728, 5312 Eleifend St.","Ap #171-9284 Erat, St.","19458990645","85465821211"),
  (8,"+7 (495) 579-61-62","Ap #740-6785 Dis St.","P.O. Box 402, 931 Tempor Ave","66635246465","75227878041"),
  (9,"+7 (495) 652-95-34","957-5118 Eget, Av.","487-9063 Dolor Av.","92481172981","57175472973"),
  (10,"+7 (495) 794-32-19","818 Lacus Ave","187-8432 A St.","47473283212","27173526672");
 
INSERT INTO documents (`filename`,`description`,`size`,`status_id`,`doc_type_id`,`supplier_id`) VALUES
  ("aliquet molestie tellus.","sollicitudin a, malesuada id,",2937,2,3,1),
  ("bibendum ullamcorper.","magna nec quam. Curabitur",4097,3,2,4),
  ("Cras vehicula aliquet","quis, pede. Praesent eu dui. Cum sociis natoque",259,2,1,1),
  ("lobortis augue scelerisque","Sed auctor odio a purus. Duis elementum,",4023,3,3,9),
  ("rhoncus. Donec","mollis dui, in sodales elit erat",2645,2,2,6),
  ("quis, tristique","et magnis dis",8820,2,3,4),
  ("ullamcorper, velit","at fringilla",9367,2,2,2),
  ("aliquam arcu. Aliquam","odio",1315,2,3,4),
  ("mauris. Morbi","consequat auctor, nunc nulla",1810,2,2,10),
  ("Donec","dignissim pharetra. Nam ac nulla. In tincidunt",3998,2,3,10);
  
  
