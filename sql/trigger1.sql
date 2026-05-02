DELIMITER $$
DROP TRIGGER IF EXISTS After_Income_Insert$$
CREATE TRIGGER After_Income_Insert
AFTER INSERT ON Income
FOR EACH ROW
BEGIN
    DECLARE v_BalanceBefore DECIMAL(15,2);
    -- Lấy số dư hiện tại
    SELECT Balance INTO v_BalanceBefore FROM BankAccounts WHERE AccountID = NEW.AccountID;
    
    -- Cập nhật số dư mới
    UPDATE BankAccounts SET Balance = Balance + NEW.Amount WHERE AccountID = NEW.AccountID;
    
    -- Ghi lịch sử
    INSERT INTO BalanceHistory (AccountID, ChangeType, AmountChanged, BalanceBefore, BalanceAfter, ReferenceType, ReferenceID, Description)
    VALUES (NEW.AccountID, 'CREDIT', NEW.Amount, v_BalanceBefore, v_BalanceBefore + NEW.Amount, 'INCOME', NEW.IncomeID, NEW.Description);
END$$

DROP TRIGGER IF EXISTS After_Expense_Insert$$
CREATE TRIGGER After_Expense_Insert
AFTER INSERT ON Expenses
FOR EACH ROW
BEGIN
    DECLARE v_BalanceBefore DECIMAL(15,2);
    SELECT Balance INTO v_BalanceBefore FROM BankAccounts WHERE AccountID = NEW.AccountID;
    
    UPDATE BankAccounts SET Balance = Balance - NEW.Amount WHERE AccountID = NEW.AccountID;
    
    INSERT INTO BalanceHistory (AccountID, ChangeType, AmountChanged, BalanceBefore, BalanceAfter, ReferenceType, ReferenceID, Description)
    VALUES (NEW.AccountID, 'DEBIT', NEW.Amount, v_BalanceBefore, v_BalanceBefore - NEW.Amount, 'EXPENSE', NEW.ExpenseID, NEW.Description);
END$$
DELIMITER ;