use librarydb;

# 🔹 Total number of books borrowed
select sum(borrow_count) as total_books_borrowed
from
	(select count(BorrowID) as borrow_count
from borrowing group by BookID) as book_borrow_counts;

-- 🔹 Count of how many times each book was borrowed (with book title)
select b.title, count(br.borrowid) as borrow_count
from borrowing br
join books b on br.bookid = b.bookid
group by b.title order by borrow_count desc;

select m.membershiptype ,count(br.borrowid) as borrow_count
from borrowing br
join members m on br.memberid = m.memberid
group by membershiptype; 

-- Average Borrowing Activity per Member
select avg(books_borrowed) as avg_borrows_per_member
from (
	select memberid, count(borrowid) as books_borrowed
	from borrowing
	group by memberid
    )
as member_borrowing;

-- creating indexes
create index idx_borrowing_member on borrowing(memberid);
create index idx_borrowing_book on borrowing(bookid);

--  Calculate Total Books Borrowed Per Month
select 
	date_format(borrowdate,'%Y-%m') as borrow_month,
    count(borrowid) as total_books_borrowed
from borrowing
group by borrow_month
order by borrow_month desc;

-- Multi-Level Grouping & Ranking
-- Find Most Popular Books Borrowed by Premium Members Only
select b.title, count(br.borrowid) as times_borrowed
from borrowing br 
join books b on br.bookid = b.bookid
join members m on br.memberid = m.memberid
where m.membershiptype = 'Premium'
group by b.title
order by times_borrowed desc
limit 3;

-- having usage
-- Find Members Who Borrowed More Than 5 Books
SELECT MemberID, COUNT(BorrowID) AS Total_Books_Borrowed
FROM Borrowing
GROUP BY MemberID
HAVING COUNT(BorrowID) > 5
ORDER BY Total_Books_Borrowed DESC;
 
-- Find Books Borrowed More Than the Average Times
SELECT BookID, COUNT(BorrowID) AS Times_Borrowed
FROM Borrowing
GROUP BY BookID
HAVING COUNT(BorrowID) > (SELECT AVG(Borrow_Count) 
						FROM (SELECT COUNT(BorrowID) AS Borrow_Count 
                        FROM Borrowing GROUP BY BookID) AS Book_Borrow_Avg)
ORDER BY Times_Borrowed DESC;

-- Find Members Who Borrowed the Maximum Number of Books
SELECT MemberID, COUNT(BorrowID) AS Total_Books_Borrowed
FROM Borrowing
GROUP BY MemberID
HAVING COUNT(BorrowID) = (SELECT MAX(Borrow_Count) 
						FROM (SELECT COUNT(BorrowID) AS Borrow_Count 
                        FROM Borrowing GROUP BY MemberID) AS Borrow_Max);

-- Handling NULL Values in Aggregation                        
-- Count Members Who Never Borrowed Books (Using COALESCE)
SELECT m.MemberID, m.Name, COALESCE(COUNT(b.BorrowID), 0) AS Total_Books_Borrowed
FROM Members m
LEFT JOIN Borrowing b ON m.MemberID = b.MemberID
GROUP BY m.MemberID, m.Name
HAVING Total_Books_Borrowed = 0;

-- Full Join usage in mysql
SELECT m.MemberID, m.Name, b.BookID, b.Title
FROM Members m
LEFT JOIN Borrowing br ON m.MemberID = br.MemberID
LEFT JOIN Books b ON br.BookID = b.BookID

UNION

SELECT m.MemberID, m.Name, b.BookID, b.Title
FROM Members m
RIGHT JOIN Borrowing br ON m.MemberID = br.MemberID
RIGHT JOIN Books b ON br.BookID = b.BookID;





