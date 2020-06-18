--Task_2
CREATE TABLE dvd (
	dvd_id	INTEGER NOT NULL,
	title	TEXT NOT NULL,
	production_year	INTEGER NOT NULL,
	PRIMARY KEY(dvd_id AUTOINCREMENT)
);
CREATE TABLE customer (
	customer_id	INTEGER NOT NULL,
	first_name	TEXT NOT NULL,
	last_name	TEXT NOT NULL,
	passport_code	INTEGER NOT NULL,
	registration_date	TEXT NOT NULL,
	PRIMARY KEY(customer_id AUTOINCREMENT)
);
CREATE TABLE offer (
	offer_id INTEGER NOT NULL,
	dvd_id	INTEGER NOT NULL,
	customer_id	INTEGER NOT NULL,
	offer_date	TEXT NOT NULL,
	return_date	TEXT,
	PRIMARY KEY(offer_id AUTOINCREMENT)
);

--Task_3
INSERT INTO dvd (title, production_year)
VALUES ('Гарри Поттер и Дары Смерти: Часть I', 2010),
       ('Веном', 2018),
	   ('Kingsman: Секретная служба', 2015),
	   ('Начало', 2010);


INSERT INTO customer (first_name, last_name, passport_code, registration_date)
VALUES ('Николаев', 'Артем', 1111, '2014-07-15'),
       ('Иванов', 'Иван', 1111, '2015-01-25'),
	   ('Петров', 'Петр', 1111, '2015-09-01');

INSERT INTO offer (dvd_id, customer_id, offer_date, return_date)
VALUES (4, 1, '2019-01-30', NULL),
       (1, 2, '2020-03-08', '2020-05-20'),
	   (2, 3, '2020-05-25', NULL);
	   
--Task 4
SELECT * FROM dvd
WHERE production_year = 2010
ORDER BY title ASC;

--Task 5
SELECT offer.return_date, dvd.title
FROM offer JOIN dvd ON offer.dvd_id = dvd.dvd_id
WHERE offer.return_date IS NULL;

--Task 6
SELECT customer.customer_id, customer.first_name, customer.last_name, customer.passport_code, customer.registration_date, 
dvd.dvd_id, dvd.title
FROM offer JOIN dvd ON offer.dvd_id = dvd.dvd_id
JOIN customer ON offer.customer_id = customer.customer_id
WHERE strftime('%Y', offer.offer_date) = '2020';