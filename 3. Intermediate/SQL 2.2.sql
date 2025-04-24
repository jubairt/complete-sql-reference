use librarydb;
-- subqueries
-- Finding Members Who Borrowed the Most Books
select memberid, name
from members
where memberid = (
		select memberid
        from borrowing
        group by memberid
        order by count(borrowid) desc
        limit 1
);

-- Correlated Subquery – Finding Members Who Borrowed More Than Their Own Average
SELECT MemberID, Name
FROM Members m
WHERE (
    SELECT COUNT(BorrowID) 
    FROM Borrowing 
    WHERE Borrowing.MemberID = m.MemberID
) > (
    SELECT AVG(Borrow_Count) 
    FROM (SELECT COUNT(BorrowID) AS Borrow_Count FROM Borrowing GROUP BY MemberID) AS AvgTable
);

-- subquery in insert
-- Add Premium Members Who Have Borrowed More Than 5 Books to a New VIP List
create table VIPMembers (
		MemberID Int primary key,
        Name varchar(150)
);

INSERT INTO VIPMembers (MemberID, Name)
SELECT MemberID, Name
FROM Members
WHERE MemberID IN (
    SELECT MemberID 
    FROM Borrowing 
    GROUP BY MemberID
    HAVING COUNT(BorrowID) > 2
);

-- Upgrade Members to ‘Premium’ if They Have Borrowed More Than 10 Books
UPDATE Members
SET MembershipType = 'premium'
WHERE MemberID IN (
    SELECT MemberID
    FROM Borrowing
    GROUP BY MemberID
    HAVING COUNT(BorrowID) > 10
);

-- Delete Members Who Have Never Borrowed a Book
DELETE FROM Members
WHERE MemberID NOT IN (
    SELECT DISTINCT MemberID FROM Borrowing
);

-- Remove Books That Have Not Been Borrowed in Over a Year
DELETE FROM Books
WHERE BookID IN (
    SELECT BookID 
    FROM Borrowing 
    WHERE BorrowDate < DATE_SUB(NOW(), INTERVAL 1 YEAR)
);

-- cross join : Generate All Possible Book-Borrower Combinations
select m.name as member_name, b.title as book_title
from members m
cross join books b;

-- Finding Members Who Joined on the Same Date
SELECT m1.Name AS Member1, m2.Name AS Member2, m1.JoinDate
FROM Members m1
JOIN Members m2 ON m1.JoinDate = m2.JoinDate
AND m1.MemberID <> m2.MemberID;

-- now(), curdate(), curtime()
select now() as date_time, curdate() as date, curtime() as time;

select borrowid, borrowdate, 
			year(borrowdate) as borrow_year,
            month(borrowdate) as borrow_month,
            day(borrowdate) as borrow_day,
            datediff(now(),borrowdate) as days_borrowed,
            date_add(borrowdate, interval 14 day) as due_date
from borrowing;




