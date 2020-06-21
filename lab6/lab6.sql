--Task 1
CREATE TABLE PC (
	id INTEGER NOT NULL,
	cpu INTEGER NOT NULL,
	memory INTEGER NOT NULL,
	hdd INTEGER NOT NULL,
	PRIMARY KEY(id AUTOINCREMENT)
);

INSERT INTO PC (cpu, memory, hdd)
VALUES (1600, 2000, 500),
       (2400, 3000, 800),
	   (3200, 3000, 1200),
	   (2400, 2000, 500);

--1
SELECT id, cpu, memory FROM PC
WHERE memory = 3000;

--2
SELECT MIN(hdd) AS hdd FROM PC;

--3
SELECT COUNT(hdd) AS count_hdd, hdd FROM PC
WHERE hdd = (SELECT MIN(hdd) FROM PC)
GROUP BY hdd;


--Task 2
CREATE TABLE track_downloads ( 
      download_id INTEGER NOT NULL, 
      track_id INTEGER NOT NULL, 
      user_id INTEGER NOT NULL, 
      download_time TIMESTAMP NOT NULL DEFAULT 0,  
      PRIMARY KEY (download_id AUTOINCREMENT) 
); 


INSERT INTO track_downloads (track_id, user_id, download_time )
VALUES (1, 1, '2010-11-19'),
       (3, 1, '2010-11-19'),
	   (2, 2, '2010-11-19'),
	   (2, 3, '2010-11-19'),
	   (4, 2, '2010-11-19'),
	   (5, 4, '2010-11-19');

--Запрос
SELECT download_count, COUNT(*) AS user_count
FROM (
	SELECT COUNT(*) AS download_count FROM track_downloads
	WHERE date(download_time) = '2010-11-19'
	GROUP BY user_id
)
GROUP BY download_count;

/*3. (#10) Опишите разницу типов данных DATETIME и TIMESTAMP
DATETIME хранит дату в формате:  'YYYY-MM-DD hh:mm:ss' в виде целого числа,
Время записанное в DATETIME не зависит от временной зоны установленной на сервере
Занимает 8 байт.
TIMESTAMP хранит значения, равное количеству секунд прошедших с полуночи 1 января 1970 года по усреднённому
времени Гринвича.При получении значения из бд возвращает дату с учетом часового пояса
Занимает 4 байт. Значение TIMESTAMP не может быть пустым и хранит по умолчанию NOW()
 */
 
 --Task 4
CREATE TABLE student (
	id_student	INTEGER NOT NULL,
	name		TEXT NOT NULL,
	PRIMARY KEY(id_student AUTOINCREMENT)
);

CREATE TABLE course (
	id_course	INTEGER NOT NULL,
	name		TEXT NOT NULL,
	PRIMARY KEY(id_course AUTOINCREMENT)
);

CREATE TABLE student_on_course (
	id_student_on_course	INTEGER NOT NULL,
	id_student	INTEGER NOT NULL,
	id_course	INTEGER NOT NULL,
	FOREIGN KEY(id_student) REFERENCES student(id_student),
	FOREIGN KEY(id_course) REFERENCES course(id_course)
	PRIMARY KEY(id_student_on_course AUTOINCREMENT)
);

INSERT INTO student (name)
VALUES ('Иван'),
       ('Сергей'),
	   ('Илья'),
	   ('Михаил'),
	   ('Ольга'),
	   ('Екатерина'),
	   ('Анастасия'),
	   ('Артем');
	   
INSERT INTO course (name)
VALUES ('ООП'),
       ('Базы данных'),
	   ('Иностранный язык'),
	   ('Физика');
	   
INSERT INTO student_on_course (id_student, id_course)
VALUES (1, 1),
       (2, 1),
	   (3, 1),
	   (4, 1),
	   (6, 1),
	   (7, 1),
	   (8, 1),
	   
	   (1, 2),
	   (2, 2),
	   (3, 2),
	   (4, 2),
	   (6, 2),
	   (7, 2),
	   (8, 2),
	   
	   (4, 3),
	   (5, 3),
	   
	   (2, 4),
	   (4, 4),
	   (5, 4),
	   (6, 4),
	   (7, 4),
	   (8, 4);
	   
--1
SELECT COUNT(id_course)
FROM (
	SELECT id_student, id_course FROM student_on_course
	GROUP BY id_course
	HAVING COUNT(student_on_course.id_student) > 5
);

--2
SELECT student.name, course.name FROM student_on_course
INNER JOIN student ON student_on_course.id_student = student.id_student
INNER JOIN course ON student_on_course.id_course = course.id_course
ORDER BY student.name ASC;

-- 5. (5#) Может ли значение в столбце(ах), на который наложено ограничение foreign key,
-- равняться null? Привидите пример.

--Может, если на него не наложено ограничение NOT NULL
--Пример
CREATE TABLE city
(
	id_city INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE region
(
	id_city INTEGER NULL,
	FOREIGN	KEY (id_city)
	REFERENCES city (id_city)
);

INSERT INTO city (id_city) 
VALUES (NULL);

/*6
Синтаксис команды: SELECT DISTINCT column_name FROM table_name
*/
CREATE TABLE schoolboy(
	id_schoolboy	INTEGER NOT NULL,
	name	TEXT NOT NULL,
	mark 	INTEGER NOT NULL,
	PRIMARY KEY(id_schoolboy AUTOINCREMENT)
);

INSERT INTO schoolboy (name, mark)
VALUES ('Максим', 4),
       ('Иван', 5),
	   ('Иван', 3),
	   ('Александр', 4);
	   
SELECT DISTINCT name FROM schoolboy;
--Вернёт Максим, Иван, Александр

SELECT DISTINCT mark FROM schoolboy;
--Вернёт 4, 5, 3

--Task 7
CREATE TABLE users (
	id_users	INTEGER NOT NULL,
	name	TEXT NOT NULL,
	PRIMARY KEY(id_users AUTOINCREMENT)
);

CREATE TABLE orders (
	id_orders	INTEGER NOT NULL,
	id_users	INTEGER NOT NULL,
	status	INTEGER NOT NULL,
	FOREIGN KEY(id_users) REFERENCES users(id_users),
	PRIMARY KEY(id_orders AUTOINCREMENT)
);

INSERT INTO users (name)
VALUES ('Иван'),
       ('Сергей'),
	   ('Илья');
	   
INSERT INTO orders (id_users, status)
VALUES (1, 0),
       (1, 0),
	   (1, 0),
	   
	   (2, 0),
	   (2, 1),
	   (2, 1),
	   (2, 1),
	   (2, 1),
	   (2, 1),
	   (2, 1),
	   
	   (3, 1),
	   (3, 1),
	   (3, 1),
	   (3, 1),
	   (3, 1),
	   (3, 1);
	   
/*8
WHERE сначала фильтрует по условию, а потом группирует
HAVING сначала группирует, а потом фильтрует по условию, 
вместе с HAVING можно использовать агрегирующие функции(count, sum, avg, min, max), а с WHERE - нет
HAVING используется только с SELECT, а выражение WHERE может использоваться с SELECT, UPDATE, DELETE.  
*/