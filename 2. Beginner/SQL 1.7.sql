create database sample;
use sample;
create table books (
		bookid int primary key auto_increment,
        title varchar(50),
        author varchar(50),
        stock int
        )
        
select * from books;