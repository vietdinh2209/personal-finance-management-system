DELIMITER $$
DROP PROCEDURE IF EXISTS AddIncomeProc$$
CREATE PROCEDURE AddIncomeProc(
    IN p_UserID INT,
    IN p_AccountID INT,
    IN p_Amount DECIMAL(15,2),
    IN p_IncomeDate DATE,
    IN p_Description VARCHAR(255)
)
BEGIN
    INSERT INTO Income (UserID, AccountID, Amount, IncomeDate, Description)
    VALUES (p_UserID, p_AccountID, p_Amount, p_IncomeDate, p_Description);
END$$
DELIMITER ;