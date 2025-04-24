use librarydb;

select * from books_backup;
set autocommit = off;
select * from books_backup;
commit;
delete from books_backup;
select * from books_backup;
rollback;
select * from books_backup;


-- Transactions
-- Step 1: Start Transaction
START TRANSACTION;

-- Step 2: Check if the book is in stock and lock the row for update
SELECT Stock 
FROM Books 
WHERE BookID = 11 
FOR UPDATE;

-- Step 3: If in stock, decrease the stock by 1
UPDATE Books 
SET Stock = Stock - 1 
WHERE BookID = 11 AND Stock > 0;

-- Step 4: Check if the update was successful (i.e., stock was greater than 0)
-- Then insert the borrowing record
INSERT INTO Borrowing (BookID, MemberID, BorrowDate)
VALUES (11, 8, NOW());
select * from borrowing;

-- Step 5: If everything went well, commit the transaction
COMMIT;
