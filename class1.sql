CREATE TABLE contacts (
	contact_id INT(11) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	first_name VARCHAR(25),
	birthday DATE
	-- CONSTRAINT contacts_pk PRIMARY KEY (contact_id)
);

ALTER TABLE contacts ADD CONSTRAINT contacts_pk PRIMARY KEY (last_name, first_name);

ALTER TABLE contacts
	ADD email varchar(40) NOT NULL
		AFTER last_name;
		
ALTER TABLE contacts
	MODIFY last_name varchar(50);

ALTER TABLE contacts
	CHANGE COLUMN birthday birth
		DATE NOT NULL;
		
ALTER TABLE contacts
	MODIFY birth
		TIMESTAMP NOT NULL;
		
-- ------------------------------------ --

CREATE TABLE products(
	product_name VARCHAR(50) NOT NULL,
	location VARCHAR(50) NOT NULL,
	category VARCHAR(25),
	CONSTRAINT products_pk PRIMARY KEY (product_name, location)
);

CREATE TABLE inventory(
	inventory_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	location VARCHAR(50) NOT NULL,
	quantity INT,
	min_level INT,
	max_level INT
);

ALTER TABLE inventory 
	ADD CONSTRAINT fk_inventory_products
		FOREIGN KEY (product_name, location)
		REFERENCES products (product_name, location);

INSERT INTO test.products
(product_name, location, category)
VALUES('producto', 'alla', 'piola');

INSERT INTO test.inventory
(inventory_id, product_name, location, quantity, min_level, max_level)
VALUES(1, 'producto', 'alla', 0, 0, 0);


		
		
		
		
		
