use librarydb;

-- 1️. ROW_NUMBER() – Unique number per row in each partition:
SELECT 
  MemberID,
  BookID,
  BorrowDate,
  ROW_NUMBER() OVER (PARTITION BY MemberID ORDER BY BorrowDate DESC) AS borrow_rank
FROM borrowing;


-- 2. RANK() – Same rank for ties, skips next:
SELECT 
  MemberID,
  BookID,
  BorrowDate,
  RANK() OVER (PARTITION BY MemberID ORDER BY BorrowDate DESC) AS borrow_rank
FROM borrowing;

-- 3. DENSE_RANK() – No gaps in rank numbers:
SELECT 
  MemberID,
  BookID,
  BorrowDate,
  DENSE_RANK() OVER (PARTITION BY MemberID ORDER BY BorrowDate DESC) AS borrow_rank
FROM borrowing;

-- 4. Aggregate with PARTITION BY and OVER()
SELECT 
  MemberID,
  BookID,
  COUNT(*) OVER (PARTITION BY MemberID) AS total_borrows
FROM borrowing;

-- 5. AVG() OVER() – Moving average:
SELECT 
  MemberID, 
  days_borrowed,
  AVG(days_borrowed) OVER (PARTITION BY MemberID ORDER BY BorrowID ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_avg
FROM borrowing;

-- 6. LAG() – Previous row value:
SELECT 
  MemberID,
  BorrowDate,
  LAG(BorrowDate) OVER (PARTITION BY MemberID ORDER BY BorrowDate) AS previous_borrow
FROM borrowing;

-- 7. MOVING AVERAGE 
SELECT 
  Author,
  Title,
  Stock,
  AVG(Stock) OVER (PARTITION BY Author ORDER BY BookID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_stock
FROM books;

-- 8. CUMULATIVE SUM (Running Total)
SELECT 
  MemberID,
  BookID,
  COUNT(*) OVER (PARTITION BY MemberID ORDER BY BorrowDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM borrowing;
