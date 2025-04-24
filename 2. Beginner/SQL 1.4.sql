use librarydb;

-- Find All Books Borrowed by a Specific Member
select B.Title, B.Author, Br.BorrowDate, Br.ReturnDate
from Borrowing Br
join Books B
on Br.BookID = B.BookID
where Br.MemberID = 1;

-- Adding new column for how many days borrowed

alter table borrowing
add column days_borrowed int;

update borrowing
set days_borrowed = datediff(ReturnDate,BorrowDate)
where BorrowID = 2;

select * from borrowing;

-- Subqueries
-- a) Inline subquery
-- 👉 These subqueries return a single value and are used within the SELECT clause
-- Find the total number of books borrowed by each member.

select 
	MemberID,
    (select count(*) from borrowing where borrowing.MemberID = members.MemberID) as TotalBooksBorrowed
from members;

-- b)  Subqueries in WHERE Clause
-- 👉 Used to filter data based on another query
-- Find all members who have borrowed at least one book.

select *
from members
where MemberID in (select distinct MemberID from borrowing);

-- c) Subqueries in FROM Clause
-- 👉 Used when you need a temporary table.
-- Find the average number of books borrowed per member.
select avg(BookCount) as AvgBooksBorrowed
from (select MemberID, count(BookID) as BookCount from borrowing group by MemberID) as BorrowedBooks;

-- Common Table Expressions
-- Find members who have borrowed more than 3 books.

select MemberID, count(BookID) from borrowing group by MemberID;


