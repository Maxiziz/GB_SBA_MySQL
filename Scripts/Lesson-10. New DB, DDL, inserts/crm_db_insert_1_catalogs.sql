USE crm;

INSERT regions (name)
VALUES 
	("Moscow"),
	("South"),
	("North-West"),
	("Ural"),
	("West Siberia"),
	("East Siberia");
	
INSERT spheres (name)
VALUES 
	("IT"),
	("Telecom"),
	("Manufacturing"),
	("Trading"),
	("Consulting"),
	("Construction"),
	("Education");
	
INSERT statuses (name)
VALUES 
	("Original"),
	("Copy"),
	("Project");
	
INSERT doc_types (name)
VALUES 
	("Contract"),
	("Supplementary agreement"),
	("Specification"),
	("Other");