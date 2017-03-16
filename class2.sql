CREATE TABLE film ( 
	film_id int NOT NULL AUTO_INCREMENT,
	title varchar(64) NOT NULL,
	description varchar(255),
	release_year varchar(4),
	CONSTRAINT pk_film PRIMARY KEY (film_id)
);

CREATE TABLE actor(
	actor_id int NOT NULL AUTO_INCREMENT,
	first_name varchar(32),
	last_name varchar(32),
	CONSTRAINT pk_actor PRIMARY KEY (actor_id)
);

CREATE TABLE film_actor(
	film_id int NOT NULL,
	actor_id int NOT NULL
);

ALTER TABLE film
	ADD last_update TIMESTAMP;
	
ALTER TABLE actor
	ADD last_update TIMESTAMP;

ALTER TABLE film_actor
	ADD CONSTRAINT fk_film_actor_film_id FOREIGN KEY (film_id) REFERENCES film(film_id); 
	
ALTER TABLE film_actor
	ADD CONSTRAINT fk_film_actor_actor_id FOREIGN KEY (actor_id) REFERENCES actor(actor_id);
	
-- INSERT ACTORS
	
INSERT INTO actor
(first_name, last_name, last_update)
VALUES ("Leonardo", "DiCaprio", CURRENT_TIMESTAMP);

INSERT INTO actor
(first_name, last_name, last_update)
VALUES ("Brad", "Pitt", CURRENT_TIMESTAMP);

INSERT INTO actor
(first_name, last_name, last_update)
VALUES ("Johnny", "Depp", CURRENT_TIMESTAMP);

INSERT INTO actor
(first_name, last_name, last_update)
VALUES ("George", "Clooney", CURRENT_TIMESTAMP);

INSERT INTO actor
(first_name, last_name, last_update)
VALUES ("Will", "Smith", CURRENT_TIMESTAMP);

-- INSERT MOVIES

INSERT INTO film
(title, description, release_year, last_update)
VALUES('Titanic', 'Barquito y boom', '1997', CURRENT_TIMESTAMP);

INSERT INTO film
(title, description, release_year, last_update)
VALUES('Sr. y Sra. Smith', 'Angelinaaa', '2005', CURRENT_TIMESTAMP);

INSERT INTO film
(title, description, release_year, last_update)
VALUES('El joven manos de tijera', 'Sharp AF', '1990', CURRENT_TIMESTAMP);

INSERT INTO film
(title, description, release_year, last_update)
VALUES('Money monster', 'Ni idea', '2016', CURRENT_TIMESTAMP);

INSERT INTO film
(title, description, release_year, last_update)
VALUES('Soy leyenda', 'El perrito :(', '2007', CURRENT_TIMESTAMP);

-- FILL RELATION

INSERT INTO film_actor
VALUES (1,1);

INSERT INTO film_actor
VALUES (2,2);

INSERT INTO film_actor
VALUES (3,3);

INSERT INTO film_actor
VALUES (4,4);

INSERT INTO film_actor
VALUES (5,5);

-- ADD DEFAULTS

ALTER TABLE film
MODIFY last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actor
MODIFY last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- SELECT * FROM actor;
-- SELECT * FROM film;
	
-- DROP TABLE film;
-- DROP TABLE actor;
-- DROP TABLE film_actor;