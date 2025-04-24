USE LibraryDB;

-- insertion operation
INSERT INTO Books (Title, Author, PublishedYear, Stock) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 5),
('To Kill a Mockingbird', 'Harper Lee', 1960, 3),
('1984', 'George Orwell', 1949, 4),
('Moby Dick', 'Herman Melville', 1851, 2),
('War and Peace', 'Leo Tolstoy', 1869, 6),
('Pride and Prejudice', 'Jane Austen', 1813, 7),
('The Catcher in the Rye', 'J.D. Salinger', 1951, 4),
('The Hobbit', 'J.R.R. Tolkien', 1937, 8),
('Fahrenheit 451', 'Ray Bradbury', 1953, 5),
('Brave New World', 'Aldous Huxley', 1932, 3),
('Crime and Punishment', 'Fyodor Dostoevsky', 1866, 2),
('The Odyssey', 'Homer', -700, 4),
('The Iliad', 'Homer', -750, 5),
('Dracula', 'Bram Stoker', 1897, 3),
('Frankenstein', 'Mary Shelley', 1818, 6);


INSERT INTO Members (Name, MembershipType) VALUES
('Alice Johnson', 'Standard'),
('Bob Smith', 'Premium'),
('Charlie Davis', 'Standard'),
('David Wilson', 'Premium'),
('Eva Adams', 'Standard'),
('Frank Thomas', 'Premium'),
('Grace Hall', 'Standard'),
('Henry Clark', 'Premium'),
('Ivy Lewis', 'Standard'),
('Jack Walker', 'Premium');


INSERT INTO Borrowing (MemberID, BookID, BorrowDate, ReturnDate) VALUES
(1, 3, '2024-01-10', NULL),
(2, 5, '2024-01-12', '2024-01-20'),
(3, 7, '2024-01-15', NULL),
(4, 9, '2024-01-18', '2024-01-28'),
(5, 11, '2024-02-01', NULL),
(6, 13, '2024-02-05', NULL),
(7, 1, '2024-02-10', NULL),
(8, 3, '2024-02-12', NULL),
(9, 5, '2024-02-15', NULL),
(10, 7, '2024-02-18', NULL),
(1, 9, '2024-02-20', NULL),
(2, 11, '2024-02-25', NULL),
(3, 13, '2024-02-28', NULL),
(4, 2, '2024-03-01', NULL),
(5, 4, '2024-03-05', NULL),
(6, 6, '2024-03-10', NULL),
(7, 8, '2024-03-12', NULL),
(8, 10, '2024-03-15', NULL),
(9, 12, '2024-03-18', NULL),
(10, 14, '2024-03-20', NULL);

