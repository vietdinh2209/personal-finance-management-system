CREATE USER IF NOT EXISTS 'finance_admin'@'localhost' IDENTIFIED BY 'Pfm@2026';
GRANT ALL PRIVILEGES ON PersonalFinanceDB.* TO 'finance_admin'@'localhost';
FLUSH PRIVILEGES;