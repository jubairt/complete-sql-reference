use librarydb;

-- This stored procedure gets all books written by a specific author.
DELIMITER //
CREATE PROCEDURE GetBooksByAuthor(IN author_name VARCHAR(255))
BEGIN
    SELECT * FROM Books WHERE Author = author_name;
END //
DELIMITER ;

CALL GetBooksByAuthor('Leo Tolstoy');


-- transaction in stored procedure
DELIMITER //
CREATE PROCEDURE TransferStock(IN book_id INT, IN quantity INT)
BEGIN
    START TRANSACTION;
    UPDATE Books SET Stock = Stock - quantity WHERE BookID = book_id;
    
    -- If stock becomes negative, cancel the transaction
    IF (SELECT Stock FROM Books WHERE BookID = book_id) < 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END //
DELIMITER ;


-- Parameters

-- IN Parameter (Sending Data into Procedure)
DELIMITER //
CREATE PROCEDURE GetboooksByauthor(IN author_name VARCHAR(255))
BEGIN
    SELECT * FROM Books WHERE Author = author_name;
END //
DELIMITER ;

CALL GetboooksByauthor('J.D. Salinger');

-- OUT Parameter (Returning Data from Procedure)
DELIMITER //
CREATE PROCEDURE GetTotalBooks(OUT book_count INT)
BEGIN
    SELECT COUNT(*) INTO book_count FROM Books;
END //
DELIMITER ;

CALL GetTotalBooks(@total);
SELECT @total;

-- INOUT Parameter (Both Input and Output)
DELIMITER //

CREATE PROCEDURE update___stock(INOUT new_stock INT, IN book_id INT)
BEGIN
    -- Add the incoming stock value
    UPDATE books SET Stock = Stock + new_stock WHERE BookID = book_id;

    -- Fetch updated stock into the same variable
    SELECT Stock INTO new_stock FROM books WHERE BookID = book_id;
END;
//

DELIMITER ;


SET @current_stock = 5;

CALL update___stock(@current_stock, 6);

SELECT @current_stock AS UpdatedStock;











