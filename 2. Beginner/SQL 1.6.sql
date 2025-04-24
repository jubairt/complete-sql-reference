use librarydb;

-- Update Stock of books in the Books table
update books
 set stock = stock + 10
 where BookID = 1;
 select * from books;
 
 -- Updating Multiple Columns
 update books
 set stock = 200, PublishedYear = 2020, Title = "Updated Book"
 where BookID = 1;
 select * from books;
 
 -- delete operation
 delete from books
 where Title = "Updated Book";
 select * from books;