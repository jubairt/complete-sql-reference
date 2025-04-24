use librarydb;

-- Performance
EXPLAIN ANALYZE
SELECT * FROM borrowing WHERE BookID = 5;

EXPLAIN
SELECT * FROM borrowing WHERE BookID = 5;

-- 2. Stored Procedure to reduce disk I/O
DELIMITER //

CREATE PROCEDURE show_books(IN id INT)
BEGIN
  SELECT * FROM borrowing WHERE MemberID = id;
END //

DELIMITER ;

CALL show_books(1);

-- 3. Profiling Stored Procedure
SET profiling = 1;

CALL show_books(1);

SHOW PROFILES;

--  4. User Privilege Restrictions
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pass';

GRANT EXECUTE ON PROCEDURE librarydb.show_books TO 'user1'@'localhost';

-- Indexes
-- 1.  B-Tree index
-- Create B-Tree index on Author (default)
CREATE INDEX book_id ON books(BookID);


-- 3. Covering index
-- Covering index (query uses only indexed columns)
CREATE INDEX idx_covering ON borrowing(BookID, MemberID);

-- Query that benefits
SELECT BookID, MemberID FROM borrowing WHERE BookID = 5;
-- ----------------
-- 4. Full-Text Index
CREATE TABLE book_reviews (
  ReviewID INT PRIMARY KEY,
  Content TEXT
);

-- Create full-text index on Content
CREATE FULLTEXT INDEX idx_review ON book_reviews(Content);

-- Example search
SELECT * FROM book_reviews
WHERE MATCH(Content) AGAINST ('great story');

-- --------------------------------

-- 5. Check Index Fragmentation & Rebuild
-- Check fragmentation (using SHOW INDEX)
SHOW INDEX FROM borrowing;

-- Rebuild index
ALTER TABLE borrowing DROP INDEX idx_covering;
CREATE INDEX idx_covering ON borrowing(BookID, MemberID);

-- --------------------------------


