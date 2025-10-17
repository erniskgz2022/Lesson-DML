create table author (
    id serial primary key ,
    name varchar,
    date_of_birth varchar,
    nationality varchar
);
alter table author add column email varchar;
alter table author drop column nationality;
alter table author alter column name set not null;
alter table author add constraint unique_email unique (email);
alter table author alter column name type text;
alter table author rename to authors;

create table Book (
                      id SERIAL PRIMARY KEY,
                      name VARCHAR(150) NOT NULL UNIQUE,
                      published_year INT,
                      author_id INT REFERENCES Authors(id)
);
insert into Authors (name, email)
values
    ('Ernest Hemingway', 'ernest@gmail.com'),
    ('Jane Austen', 'jane.austen@mail.com');

insert into Book (name, published_year, author_id)
values
    ('The Old Man and the Sea', 1952, 1),
    ('A Farewell to Arms', 1929, 1),
    ('For Whom the Bell Tolls', 1940, 1),
    ('Pride and Prejudice', 1813, 2),
    ('Sense and Sensibility', 1811, 2),
    ('Emma', 1815, 2);
