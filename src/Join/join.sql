-- Таблица Reader
CREATE TABLE Reader
(
    id            SERIAL PRIMARY KEY,
    full_name     VARCHAR(100)        NOT NULL,
    gender        VARCHAR(10) CHECK (gender IN ('male', 'female')),
    email         VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE                NOT NULL
);
-- Таблица Book
CREATE TABLE Book
(
    id             SERIAL PRIMARY KEY,
    book_name      VARCHAR(100) NOT NULL,
    genre          VARCHAR(50),
    published_year INT,
    price          NUMERIC(10, 2),
    is_booked      BOOLEAN DEFAULT false
);
-- Таблица Author
CREATE TABLE Author
(
    id        SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender    VARCHAR(10) CHECK (gender IN ('male', 'female')),
    book_id   INT REFERENCES Book (id)
);
-- Таблица Library
CREATE TABLE Library
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    book_id   INT REFERENCES Book (id),
    reader_id INT REFERENCES Reader (id)
);
-- Readers
INSERT INTO Reader (full_name, gender, email, date_of_birth)
VALUES ('Elnura Arapova', 'female', 'elnura@gmail.com', '2002-05-20'),
       ('Sanjar Suanbekov', 'male', 'sanjar@gmail.com', '1995-03-14'),
       ('Chyngyz Zalkarbekov', 'male', 'chyngyz@gmail.com', '1999-10-30'),
       ('Symbat Salyamov', 'male', 'symbat@gmail.com', '1990-11-11'),
       ('Fatima Altynbek kyzy', 'female', 'fati@gmail.com', '2001-07-22'),
       ('Baitenir Busurmanov', 'male', 'baitenir@gmail.com', '1988-01-05'),
       ('Sanjar Orozobekov', 'male', 'sanjar.o@gmail.com', '1994-06-09'),
       ('Nurpazyl Nabiev', 'male', 'nurpazyl@gmail.com', '1998-02-14'),
       ('Junusbek Abdurahmanov', 'male', 'junus@gmail.com', '2004-01-14'),
       ('Abdulkudus Imarov', 'male', 'abdu@gmail.com', '1998-12-14'),
       ('Artur Rakhmanov', 'male', 'artur@gmail.com', '2000-09-04');
-- Books
INSERT INTO Book (book_name, genre, published_year, price, is_booked)
VALUES ('War and Peace', 'Historical', 1869, 1500.00, true),         -- 1
       ('Harry Potter', 'Fantasy', 2001, 900.00, false),             -- 2
       ('Clean Code', 'Programming', 2008, 1200.00, true),           -- 3
       ('1984', 'Dystopian', 1949, 800.00, false),                   -- 4
       ('Python Crash Course', 'Programming', 2016, 1300.00, false), -- 5
       ('The Great Gatsby', 'Classic', 1925, 950.00, true),          -- 6
       ('The Hobbit', 'Fantasy', 1937, 1000.00, false),              -- 7
       ('Sapiens', 'History', 2011, 1600.00, true);
-- 8
-- Authors
INSERT INTO Author (full_name, gender, book_id)
VALUES ('Leo Tolstoy', 'male', 1),
       ('J.K. Rowling', 'female', 2),
       ('Robert C. Martin', 'male', 3),
       ('George Orwell', 'male', 4),
       ('Eric Matthes', 'male', 5),
       ('F. Scott Fitzgerald', 'male', 6),
       ('J.R.R. Tolkien', 'male', 7),
       ('Yuval Noah Harari', 'male', 8);
-- Libraries
INSERT INTO Library (name, book_id, reader_id)
VALUES ('Central Library', 1, 1),
       ('Youth Library', 2, 2),
       ('Tech Library', 3, 3),
       ('City Library', 4, 4),
       ('IT Library', 5, 5),
       ('Classic Library', 6, 6),
       ('Children Library', 7, 7),
       ('Historical Library', 8, 8),
       ('Central Library', 2, 9),
       ('Tech Library', 5, 10),
       ('Youth Library', 6, 11),
       ('City Library', 1, 2);


-- 1. Получить все записи из таблицы Library
    select * from Library;
-- 2. Найти библиотеки, где читают книги авторов мужского пола
    select l.name, a.full_name, a.gender from Library l join Book B on l.book_id = B.id join Author A on B.id = A.book_id
    where a.gender = 'male';
-- 3. Подсчитать количество книг в каждой библиотеке
    select l.name as library_name, count(book_id) as book_count from Library l
    join book b on l.book_id = book_id group by l.name;
-- 4. Получить библиотеки вместе с названиями книг
    select l.name as library_name, b.book_name from Library l
    join Book b on l.book_id = b.id;
-- 5. Получить библиотеки и полные имена читателей
    select l.name as library_name, r.full_name as reader_name from Library l
    join Reader r on l.reader_id = r.id;
-- 6. Получить количество книг в каждой библиотеке
select l.name as library_name, count(book_id) as book_count from Library l
   join book b on l.book_id = book_id group by l.name;
-- 7. Вывести библиотеки, в которых книга сейчас "забронирована" (is_booked = true)
    select distinct  l.name from Library l
    join Book b on l.book_id = b.id where b.is_booked = true;
-- 8. Вывести библиотеки, где читатель — женщина
    select distinct l.name from Library l
    join Reader r on l.reader_id = r.id
    where   r.gender = 'Female';
-- 9.Получить библиотеку и автора её книги
select distinct l.name as library_name, a.full_name as author_name from Library l
    join Book b on l.book_id = b.id
    join Author a on b.id = a.book_id;
-- 10.Вывести библиотеки, у которых книги стоят больше 1000
select distinct l.name from Library l
join Book b on l.book_id = b.id
where b.price > 1000;

-- Reader
-- 1.Получить всех читателей
    select * from Reader;
-- 2.Читатели и библиотеки, где они зарегистрированы:
    
-- 3.Читатели и названия книг, которые они читают
-- 4.Получить читателей и книги, которые они читают
-- 5.Читатели и авторы прочитанных книг
-- 6.Вывести читателей, читающих определённый жанр
-- 7.Получить всех читателей, читающих книги, изданные после 2010
-- 8.Найти читателей, у которых книги написаны женщинами

-- Book
-- 1.Получить все книги
-- 2.Книги и библиотеки, где они находятся
-- 3.Получить книги и авторы
-- 4.Получить книги и читатели
-- 5.Книги, изданные после 2010 года
-- 6.Книги с определенным жанром
-- 7.Книги, которые забронированы
-- 8.Количество книг по жанрам
-- 9.Книга и библиотека, отсортированные по цене


-- Author
-- 1.Все авторы
-- 2.Авторы и их книги
-- 3.Авторы и библиотеки
-- 4.Авторы и читатели
-- 5.Авторы без книг
-- 6.Авторы, у которых книги не забронированы
-- 7.Авторы, написавшие книги в жанре "Programming"
-- 8.Отсортировать авторов по алфавиту
-- 9.Книга и библиотека, отсортированные по цене