USE PersonalFinanceDB;

-- Dọn dẹp dữ liệu rác (nếu có) và reset ID về 1
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE BalanceHistory;
TRUNCATE TABLE Expenses;
TRUNCATE TABLE Income;
TRUNCATE TABLE BankAccounts;
TRUNCATE TABLE ExpenseCategories;
TRUNCATE TABLE Users;
SET FOREIGN_KEY_CHECKS = 1;

-- Thêm người dùng (Nhóm của bạn)
INSERT INTO Users (UserName, Email, PhoneNumber) VALUES
('Dinh Quoc Viet', 'viet.dq@gmail.com', '0981234567'),
('Kieu Minh Ngoc', 'ngoc.km@gmail.com', '0972345678'),
('Dang Quynh Trang', 'trang.dq@gmail.com', '0963456789'),
('Dinh Linh', 'linh.d@gmail.com', '0954567890'),
('Dinh Quang Thai', 'thai.dq@gmail.com', '0945678901'),
('Le Thanh Tra', 'tra.lt@gmail.com', '0936789012');

-- Thêm Danh mục chi tiêu
INSERT INTO ExpenseCategories (CategoryName) VALUES
('Food & Dining'), ('Transportation'), ('Education'), ('Entertainment'), ('Utilities');

-- Thêm Tài khoản ngân hàng
INSERT INTO BankAccounts (UserID, BankName, Balance) VALUES
(1, 'Vietcombank', 12500000.00),
(2, 'Techcombank', 8400000.00),
(3, 'MB Bank', 25000000.00),
(4, 'BIDV', 5600000.00),
(5, 'TPBank', 18900000.00),
(6, 'VietinBank', 9200000.00);

-- Thêm Thu nhập
INSERT INTO Income (UserID, AccountID, Amount, IncomeDate, Description) VALUES
(1, 1, 15000000.00, '2026-04-01', 'Salary April'),
(2, 2, 12000000.00, '2026-04-05', 'Salary April'),
(3, 3, 5000000.00, '2026-04-10', 'Project Bonus'),
(4, 4, 8000000.00, '2026-04-15', 'Freelance'),
(5, 5, 20000000.00, '2026-04-02', 'Salary April'),
(6, 6, 10000000.00, '2026-04-05', 'Salary April');

-- Thêm Chi tiêu (Đa dạng cho Việt - UserID 1 để lát vẽ biểu đồ cho đẹp)
INSERT INTO Expenses (UserID, CategoryID, AccountID, Amount, ExpenseDate, Description) VALUES
(1, 1, 1, 500000.00, '2026-04-05', 'Dinner with friends'),
(1, 2, 1, 300000.00, '2026-04-10', 'Gasoline'),
(1, 3, 1, 2500000.00, '2026-04-15', 'English Course'),
(1, 4, 1, 400000.00, '2026-04-20', 'Cinema tickets'),
(2, 1, 2, 600000.00, '2026-04-06', 'Groceries'),
(3, 3, 3, 2000000.00, '2026-04-12', 'Books'),
(4, 4, 4, 150000.00, '2026-04-16', 'Netflix'),
(5, 5, 5, 1000000.00, '2026-04-20', 'Electricity bill'),
(6, 1, 6, 450000.00, '2026-04-22', 'Cafe');