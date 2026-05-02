CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15)
);

CREATE TABLE ExpenseCategories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE BankAccounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    BankName VARCHAR(100) NOT NULL,
    Balance DECIMAL(15, 2) DEFAULT 0.00,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Income (
    IncomeID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    AccountID INT,
    Amount DECIMAL(15, 2) NOT NULL,
    IncomeDate DATE NOT NULL,
    Description VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (AccountID) REFERENCES BankAccounts(AccountID) ON DELETE CASCADE
);

CREATE TABLE Expenses (
    ExpenseID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    CategoryID INT,
    AccountID INT,
    Amount DECIMAL(15, 2) NOT NULL,
    ExpenseDate DATE NOT NULL,
    Description VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES ExpenseCategories(CategoryID),
    FOREIGN KEY (AccountID) REFERENCES BankAccounts(AccountID) ON DELETE CASCADE
);

CREATE TABLE BalanceHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT,
    ChangeType VARCHAR(20), 
    AmountChanged DECIMAL(15, 2) NOT NULL,
    BalanceBefore DECIMAL(15, 2) NOT NULL,
    BalanceAfter DECIMAL(15, 2) NOT NULL,
    ChangedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    ReferenceType VARCHAR(50), 
    ReferenceID INT,
    Description VARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES BankAccounts(AccountID) ON DELETE CASCADE
);