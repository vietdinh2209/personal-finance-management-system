USE PersonalFinanceDB;

-- Bỏ qua lỗi nếu Index đã tồn tại bằng cách tạo tên chuẩn xác
CREATE INDEX idx_income_user_date ON Income(UserID, IncomeDate);
CREATE INDEX idx_expense_user_date ON Expenses(UserID, ExpenseDate);
CREATE INDEX idx_expense_category ON Expenses(CategoryID);