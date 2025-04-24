use sample;
SELECT * FROM sample.books;
insert into books ( title, author, stock)
values 
('harry potter','jk rowling',45),
('harry potter','jk rowling',45),
('x', 'one',65),
('harry potter','jk rowling',45),
('y','two', 56),
('a','three',74),
('harry potter','jk rowling',45);


select title, count(*) as book_count from books group by title;


