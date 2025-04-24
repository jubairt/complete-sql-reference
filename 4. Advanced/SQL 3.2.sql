use librarydb;

-- Funtions
DELIMITER //
CREATE FUNCTION GetBookCount() RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalBooks INT;
    SELECT COUNT(*) INTO totalBooks FROM Books;
    RETURN totalBooks;
END //
DELIMITER ;

SELECT GetBookCount();      -- Calling a function

-- 💡 Example 1: Return a fixed message
DELIMITER //

CREATE FUNCTION sayHello()
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
  RETURN 'Hello from Library!';
END //

DELIMITER ;

SELECT sayHello();

-- 💡 Example 2: Add 5 to a number
DELIMITER //

CREATE FUNCTION addFive(x INT)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN x + 5;
END //

DELIMITER ;

SELECT addFive(10);  -- Output: 15

-- 💡 Example 3: Get book title from BookID
DELIMITER //

CREATE FUNCTION getTitle(bid INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE t VARCHAR(100);
  SELECT Title INTO t FROM books WHERE BookID = bid;
  RETURN t;
END //

DELIMITER ;

SELECT getTitle(6);  -- Output: the title of book with ID 1

