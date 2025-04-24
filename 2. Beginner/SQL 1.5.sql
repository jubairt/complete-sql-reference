-- basic syntaxes
use librarydb;
select * from members where not MembershipType = "Premium";
select * from members where Name like '%John%';

-- Find books where the title has exactly 5 characters
SELECT * FROM Books WHERE Title LIKE '_______';

select * from books order by Author asc, Title asc;

-- Find books published after 2000 and sort them by stock availability
SELECT * FROM Books WHERE PublishedYear > 2000 ORDER BY Stock DESC;

--  Sort books by Stock after adding 10 new copies
select *, (stock + 10) as adjusted_stock from books
order by adjusted_stock asc;

-- Get the top 5 most recently added books
select * from books order by PublishedYear desc limit 5;

--  Get the 3 members who have borrowed the most books
select count(*) from borrowing group by memberid;

-- Find distinct book and borrower pairs
select distinct MemberID, BookID from borrowing;

-- Skip the first 5 books and get the next 5
select * from books limit 5 offset 5;

-- To find all books that haven't been returned
select * from borrowing where ReturnDate is null;

-- Show "Not Returned Yet" if ReturnDate is NULL
select *, coalesce(ReturnDate,'not returned yet') as return_status;

select * from books
where Author in ('Aldous Huxley','Fyodor Dostoevsky');

--  Find Books Published Between 2000 and 2020
select * from books 
where PublishedYear between 1900 and 1950;

-- copy to books_backup
CREATE TABLE Books_backup (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    PublishedYear INT,
    Stock INT DEFAULT 0
);

insert into books_backup ( Title, Author, PublishedYear, Stock)
select Title, Author, PublishedYear, Stock from books;
select * from books_backup;




