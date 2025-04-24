CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Creating operation
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    PublishedYear INT,
    Stock INT DEFAULT 0
);

        
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    JoinDate DATE DEFAULT (CURRENT_DATE),
    MembershipType ENUM('Standard', 'Premium') NOT NULL
);

        
CREATE TABLE Borrowing (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    BorrowDate DATE DEFAULT (CURRENT_DATE),
    ReturnDate DATE DEFAULT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);



