use librarydb;

-- EXISTS vs. IN
-- ❌ Using IN:
SELECT Name FROM members
WHERE MemberID IN (SELECT MemberID FROM borrowing);

-- ✅ Using EXISTS (better for large data):
SELECT Name FROM members m
WHERE EXISTS (
  SELECT 1 FROM borrowing br WHERE br.MemberID = m.MemberID
);

-- 1. ACID + Simple Transaction Example
START TRANSACTION;

UPDATE books SET Stock = Stock - 1 WHERE BookID = 1;
INSERT INTO borrowing (BorrowID, MemberID, BookID, BorrowDate)
VALUES (101, 1, 1, CURDATE());

COMMIT;


--  2. Row-Level Locking Example
-- This locks only 1 row
START TRANSACTION;
SELECT * FROM books WHERE BookID = 13 FOR UPDATE;
-- Do some update...
UPDATE books SET Stock = Stock - 1 WHERE BookID = 13;
COMMIT;

-- 3. Table-Level Locking Example
LOCK TABLES books WRITE;

UPDATE books SET Stock = Stock + 1 WHERE BookID = 2;

UNLOCK TABLES;

-- 4. Pessimistic Locking (with SELECT FOR UPDATE)
START TRANSACTION;
SELECT * FROM books WHERE BookID = 1 FOR UPDATE;
UPDATE books SET Stock = Stock - 1 WHERE BookID = 1;
COMMIT;

-- ----------------------------
-- 5. Isolation Level Demo
-- 🔹 Set isolation level for the session:
-- Read Uncommitted
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Example Transaction
START TRANSACTION;
SELECT * FROM books;
COMMIT;

-- 🔹 You can try these other levels too:
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- -- ----------------------------

-- Partitioning
--  1. RANGE Partitioning (by Published Year)
CREATE TABLE books_partitioned (
  BookID INT,
  Title VARCHAR(100),
  Author VARCHAR(100),
  PublishedYear INT,
  Stock INT
)
PARTITION BY RANGE (PublishedYear) (
  PARTITION p1 VALUES LESS THAN (2000),
  PARTITION p2 VALUES LESS THAN (2010),
  PARTITION p3 VALUES LESS THAN (2020),
  PARTITION p4 VALUES LESS THAN MAXVALUE
);

--  2. LIST Partitioning (by Genre)
CREATE TABLE books_by_genre (
  BookID INT,
  Title VARCHAR(100),
  Author VARCHAR(100),
  Genre VARCHAR(50)
)
PARTITION BY LIST COLUMNS (Genre) (
  PARTITION fiction VALUES IN ('Fiction'),
  PARTITION science VALUES IN ('Science'),
  PARTITION others VALUES IN ('History', 'Comics', 'Poetry')
);

--  3. HASH Partitioning (Even Distribution)
CREATE TABLE borrowing_partitioned (
  BorrowID INT,
  MemberID INT,
  BookID INT,
  BorrowDate DATE
)
PARTITION BY HASH(BookID)
PARTITIONS 4;

--  4. Composite Partitioning (RANGE + HASH)
CREATE TABLE book_sales (
  BookID INT,
  SaleYear INT,
  RegionID INT
)
PARTITION BY RANGE (SaleYear)
SUBPARTITION BY HASH(RegionID)
SUBPARTITIONS 2 (
  PARTITION p1 VALUES LESS THAN (2010),
  PARTITION p2 VALUES LESS THAN (2020),
  PARTITION p3 VALUES LESS THAN MAXVALUE
);



