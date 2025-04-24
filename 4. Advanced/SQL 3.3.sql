use librarydb;

-- table for borrow_log
CREATE TABLE borrow_log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  log_message VARCHAR(255),
  log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1️. BEFORE INSERT → Set days_borrowed to 7
CREATE TRIGGER set_default_days
BEFORE INSERT ON borrowing
FOR EACH ROW
SET NEW.days_borrowed = 7;
-- checking
INSERT INTO borrowing (MemberID, BookID, BorrowDate)
VALUES (1, 101, '2025-04-23');

-- 2️. AFTER INSERT → Log message
CREATE TRIGGER log_borrow
AFTER INSERT ON borrowing
FOR EACH ROW
INSERT INTO borrow_log (log_message)
VALUES ('A new borrow record was added');

DELIMITER //
-- checking
INSERT INTO borrowing (MemberID, BookID, BorrowDate)
VALUES (1, 101, '2025-04-23');

-- 3. BEFORE UPDATE → Block BookID change
CREATE TRIGGER block_bookid_change
BEFORE UPDATE ON borrowing
FOR EACH ROW
BEGIN
  IF OLD.BookID != NEW.BookID THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'BookID cannot be changed';
  END IF;
END //

DELIMITER ;
-- checking
UPDATE borrowing
SET BookID = 202
WHERE BorrowID = 2;

-- 4. AFTER UPDATE → Log days_borrowed change
DELIMITER //

CREATE TRIGGER log_days_change
AFTER UPDATE ON borrowing
FOR EACH ROW
BEGIN
  IF OLD.days_borrowed != NEW.days_borrowed THEN
    INSERT INTO borrow_log (log_message)
    VALUES ('days_borrowed was updated');
  END IF;
END //

DELIMITER ;
-- checking
UPDATE borrowing
SET days_borrowed = 10
WHERE BorrowID = 2;

-- 5. BEFORE DELETE → Log before deletion
CREATE TRIGGER log_before_delete
BEFORE DELETE ON borrowing
FOR EACH ROW
INSERT INTO borrow_log (log_message)
VALUES ('A borrow record is about to be deleted');
-- checking
DELETE FROM borrowing
WHERE BorrowID = 2;

-- 6. AFTER DELETE → Log after deletion
CREATE TRIGGER log_after_delete
AFTER DELETE ON borrowing
FOR EACH ROW
INSERT INTO borrow_log (log_message)
VALUES ('A borrow record was deleted');

DELETE FROM borrowing
WHERE BorrowID = 3;



