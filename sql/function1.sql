USE PersonalFinanceDB;
DELIMITER $$
DROP FUNCTION IF EXISTS fn_total_income$$
CREATE FUNCTION fn_total_income(f_UserID INT, f_Month INT, f_Year INT) 
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(15,2);
    SELECT IFNULL(SUM(Amount), 0) INTO total 
    FROM Income 
    WHERE UserID = f_UserID AND MONTH(IncomeDate) = f_Month AND YEAR(IncomeDate) = f_Year;
    RETURN total;
END$$
DELIMITER ;