-- MySQL dump 10.13  Distrib 8.4.7, for Win64 (x86_64)
--
-- Host: localhost    Database: PersonalFinanceDB
-- ------------------------------------------------------
-- Server version	8.4.7

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `balancehistory`
--

DROP TABLE IF EXISTS `balancehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `balancehistory` (
  `HistoryID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int DEFAULT NULL,
  `ChangeType` varchar(20) DEFAULT NULL,
  `AmountChanged` decimal(15,2) NOT NULL,
  `BalanceBefore` decimal(15,2) NOT NULL,
  `BalanceAfter` decimal(15,2) NOT NULL,
  `ChangedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `ReferenceType` varchar(50) DEFAULT NULL,
  `ReferenceID` int DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HistoryID`),
  KEY `AccountID` (`AccountID`),
  CONSTRAINT `balancehistory_ibfk_1` FOREIGN KEY (`AccountID`) REFERENCES `bankaccounts` (`AccountID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balancehistory`
--

LOCK TABLES `balancehistory` WRITE;
/*!40000 ALTER TABLE `balancehistory` DISABLE KEYS */;
INSERT INTO `balancehistory` VALUES (1,1,'DEBIT',200000.00,12500000.00,12300000.00,'2026-05-03 01:41:16','EXPENSE',10,'Test Trigger');
/*!40000 ALTER TABLE `balancehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `balancehistoryview`
--

DROP TABLE IF EXISTS `balancehistoryview`;
/*!50001 DROP VIEW IF EXISTS `balancehistoryview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `balancehistoryview` AS SELECT 
 1 AS `HistoryID`,
 1 AS `AccountID`,
 1 AS `UserName`,
 1 AS `BankName`,
 1 AS `ChangeType`,
 1 AS `AmountChanged`,
 1 AS `BalanceBefore`,
 1 AS `BalanceAfter`,
 1 AS `ChangedAt`,
 1 AS `ReferenceType`,
 1 AS `Description`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bankaccounts`
--

DROP TABLE IF EXISTS `bankaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bankaccounts` (
  `AccountID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `BankName` varchar(100) NOT NULL,
  `Balance` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`AccountID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `bankaccounts_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bankaccounts`
--

LOCK TABLES `bankaccounts` WRITE;
/*!40000 ALTER TABLE `bankaccounts` DISABLE KEYS */;
INSERT INTO `bankaccounts` VALUES (1,1,'Vietcombank',12300000.00),(2,2,'Techcombank',8400000.00),(3,3,'MB Bank',25000000.00),(4,4,'BIDV',5600000.00),(5,5,'TPBank',18900000.00),(6,6,'VietinBank',9200000.00);
/*!40000 ALTER TABLE `bankaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `categoryspendingview`
--

DROP TABLE IF EXISTS `categoryspendingview`;
/*!50001 DROP VIEW IF EXISTS `categoryspendingview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `categoryspendingview` AS SELECT 
 1 AS `CategoryName`,
 1 AS `TotalSpent`,
 1 AS `SpendingMonth`,
 1 AS `SpendingYear`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `expensecategories`
--

DROP TABLE IF EXISTS `expensecategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expensecategories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expensecategories`
--

LOCK TABLES `expensecategories` WRITE;
/*!40000 ALTER TABLE `expensecategories` DISABLE KEYS */;
INSERT INTO `expensecategories` VALUES (1,'Food & Dining'),(2,'Transportation'),(3,'Education'),(4,'Entertainment'),(5,'Utilities');
/*!40000 ALTER TABLE `expensecategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses` (
  `ExpenseID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `CategoryID` int DEFAULT NULL,
  `AccountID` int DEFAULT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `ExpenseDate` date NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ExpenseID`),
  KEY `AccountID` (`AccountID`),
  KEY `idx_expense_user_date` (`UserID`,`ExpenseDate`),
  KEY `idx_expense_category` (`CategoryID`),
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `expensecategories` (`CategoryID`),
  CONSTRAINT `expenses_ibfk_3` FOREIGN KEY (`AccountID`) REFERENCES `bankaccounts` (`AccountID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
INSERT INTO `expenses` VALUES (1,1,1,1,500000.00,'2026-04-05','Dinner with friends'),(2,1,2,1,300000.00,'2026-04-10','Gasoline'),(3,1,3,1,2500000.00,'2026-04-15','English Course'),(4,1,4,1,400000.00,'2026-04-20','Cinema tickets'),(5,2,1,2,600000.00,'2026-04-06','Groceries'),(6,3,3,3,2000000.00,'2026-04-12','Books'),(7,4,4,4,150000.00,'2026-04-16','Netflix'),(8,5,5,5,1000000.00,'2026-04-20','Electricity bill'),(9,6,1,6,450000.00,'2026-04-22','Cafe'),(10,1,1,1,200000.00,'2026-04-26','Test Trigger');
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `After_Expense_Insert` AFTER INSERT ON `expenses` FOR EACH ROW BEGIN
    DECLARE v_BalanceBefore DECIMAL(15,2);
    SELECT Balance INTO v_BalanceBefore FROM BankAccounts WHERE AccountID = NEW.AccountID;
    
    UPDATE BankAccounts SET Balance = Balance - NEW.Amount WHERE AccountID = NEW.AccountID;
    
    INSERT INTO BalanceHistory (AccountID, ChangeType, AmountChanged, BalanceBefore, BalanceAfter, ReferenceType, ReferenceID, Description)
    VALUES (NEW.AccountID, 'DEBIT', NEW.Amount, v_BalanceBefore, v_BalanceBefore - NEW.Amount, 'EXPENSE', NEW.ExpenseID, NEW.Description);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `income`
--

DROP TABLE IF EXISTS `income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `income` (
  `IncomeID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `AccountID` int DEFAULT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `IncomeDate` date NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IncomeID`),
  KEY `AccountID` (`AccountID`),
  KEY `idx_income_user_date` (`UserID`,`IncomeDate`),
  CONSTRAINT `income_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `income_ibfk_2` FOREIGN KEY (`AccountID`) REFERENCES `bankaccounts` (`AccountID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income`
--

LOCK TABLES `income` WRITE;
/*!40000 ALTER TABLE `income` DISABLE KEYS */;
INSERT INTO `income` VALUES (1,1,1,15000000.00,'2026-04-01','Salary April'),(2,2,2,12000000.00,'2026-04-05','Salary April'),(3,3,3,5000000.00,'2026-04-10','Project Bonus'),(4,4,4,8000000.00,'2026-04-15','Freelance'),(5,5,5,20000000.00,'2026-04-02','Salary April'),(6,6,6,10000000.00,'2026-04-05','Salary April'),(7,1,1,800000.00,'2026-04-25','Test Procedure');
/*!40000 ALTER TABLE `income` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `After_Income_Insert` AFTER INSERT ON `income` FOR EACH ROW BEGIN
    DECLARE v_BalanceBefore DECIMAL(15,2);
    -- Lấy số dư hiện tại
    SELECT Balance INTO v_BalanceBefore FROM BankAccounts WHERE AccountID = NEW.AccountID;
    
    -- Cập nhật số dư mới
    UPDATE BankAccounts SET Balance = Balance + NEW.Amount WHERE AccountID = NEW.AccountID;
    
    -- Ghi lịch sử
    INSERT INTO BalanceHistory (AccountID, ChangeType, AmountChanged, BalanceBefore, BalanceAfter, ReferenceType, ReferenceID, Description)
    VALUES (NEW.AccountID, 'CREDIT', NEW.Amount, v_BalanceBefore, v_BalanceBefore + NEW.Amount, 'INCOME', NEW.IncomeID, NEW.Description);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `monthlysummaryview`
--

DROP TABLE IF EXISTS `monthlysummaryview`;
/*!50001 DROP VIEW IF EXISTS `monthlysummaryview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `monthlysummaryview` AS SELECT 
 1 AS `UserName`,
 1 AS `TotalIncome`,
 1 AS `Month`,
 1 AS `Year`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Dinh Quoc Viet','viet.dq@gmail.com','0981234567'),(2,'Kieu Minh Ngoc','ngoc.km@gmail.com','0972345678'),(3,'Dang Quynh Trang','trang.dq@gmail.com','0963456789'),(4,'Dinh Linh','linh.d@gmail.com','0954567890'),(5,'Dinh Quang Thai','thai.dq@gmail.com','0945678901'),(6,'Le Thanh Tra','tra.lt@gmail.com','0936789012');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'PersonalFinanceDB'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_total_income` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_income`(f_UserID INT, f_Month INT, f_Year INT) RETURNS decimal(15,2)
    DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(15,2);
    SELECT IFNULL(SUM(Amount), 0) INTO total 
    FROM Income 
    WHERE UserID = f_UserID AND MONTH(IncomeDate) = f_Month AND YEAR(IncomeDate) = f_Year;
    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddIncomeProc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddIncomeProc`(
    IN p_UserID INT,
    IN p_AccountID INT,
    IN p_Amount DECIMAL(15,2),
    IN p_IncomeDate DATE,
    IN p_Description VARCHAR(255)
)
BEGIN
    INSERT INTO Income (UserID, AccountID, Amount, IncomeDate, Description)
    VALUES (p_UserID, p_AccountID, p_Amount, p_IncomeDate, p_Description);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `balancehistoryview`
--

/*!50001 DROP VIEW IF EXISTS `balancehistoryview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `balancehistoryview` AS select `h`.`HistoryID` AS `HistoryID`,`h`.`AccountID` AS `AccountID`,`u`.`UserName` AS `UserName`,`b`.`BankName` AS `BankName`,`h`.`ChangeType` AS `ChangeType`,`h`.`AmountChanged` AS `AmountChanged`,`h`.`BalanceBefore` AS `BalanceBefore`,`h`.`BalanceAfter` AS `BalanceAfter`,`h`.`ChangedAt` AS `ChangedAt`,`h`.`ReferenceType` AS `ReferenceType`,`h`.`Description` AS `Description` from ((`balancehistory` `h` join `bankaccounts` `b` on((`h`.`AccountID` = `b`.`AccountID`))) join `users` `u` on((`b`.`UserID` = `u`.`UserID`))) order by `h`.`ChangedAt` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `categoryspendingview`
--

/*!50001 DROP VIEW IF EXISTS `categoryspendingview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `categoryspendingview` AS select `c`.`CategoryName` AS `CategoryName`,sum(`e`.`Amount`) AS `TotalSpent`,month(`e`.`ExpenseDate`) AS `SpendingMonth`,year(`e`.`ExpenseDate`) AS `SpendingYear` from (`expenses` `e` join `expensecategories` `c` on((`e`.`CategoryID` = `c`.`CategoryID`))) group by `c`.`CategoryName`,`SpendingMonth`,`SpendingYear` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `monthlysummaryview`
--

/*!50001 DROP VIEW IF EXISTS `monthlysummaryview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `monthlysummaryview` AS select `u`.`UserName` AS `UserName`,sum(`i`.`Amount`) AS `TotalIncome`,month(`i`.`IncomeDate`) AS `Month`,year(`i`.`IncomeDate`) AS `Year` from (`users` `u` join `income` `i` on((`u`.`UserID` = `i`.`UserID`))) group by `u`.`UserName`,`Month`,`Year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-03  1:58:36
