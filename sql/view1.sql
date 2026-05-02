USE PersonalFinanceDB;

-- Tạo View thống kê chi tiêu theo danh mục
CREATE OR REPLACE VIEW CategorySpendingView AS
SELECT 
    c.CategoryName, 
    SUM(e.Amount) AS TotalSpent, 
    MONTH(e.ExpenseDate) AS SpendingMonth, 
    YEAR(e.ExpenseDate) AS SpendingYear
FROM Expenses e
JOIN ExpenseCategories c ON e.CategoryID = c.CategoryID
GROUP BY c.CategoryName, SpendingMonth, SpendingYear;

-- Tạo View thống kê Thu nhập theo tháng
CREATE OR REPLACE VIEW MonthlySummaryView AS
SELECT 
    u.UserName, 
    SUM(i.Amount) AS TotalIncome, 
    MONTH(i.IncomeDate) AS Month, 
    YEAR(i.IncomeDate) AS Year
FROM Users u 
JOIN Income i ON u.UserID = i.UserID
GROUP BY u.UserName, Month, Year;

-- Tạo View xem lịch sử biến động số dư
CREATE OR REPLACE VIEW BalanceHistoryView AS
SELECT 
    h.HistoryID, h.AccountID, u.UserName, b.BankName, 
    h.ChangeType, h.AmountChanged, h.BalanceBefore, h.BalanceAfter, 
    h.ChangedAt, h.ReferenceType, h.Description
FROM BalanceHistory h
JOIN BankAccounts b ON h.AccountID = b.AccountID
JOIN Users u ON b.UserID = u.UserID
ORDER BY h.ChangedAt DESC;