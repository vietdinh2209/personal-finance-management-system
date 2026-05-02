# 📊 Personal Finance Management System

## 1. Project Overview
The **Personal Finance Management System** is a database-driven application designed to help users track and manage their financial activities practically and systematically. The system allows users to record income, categorize expenses, manage multiple bank accounts, and maintain an automated history of account balances.
By combining a **MySQL** database for secure data management and a **Python** command-line interface (CLI) for interaction, this project aims to provide a structured environment where users can monitor spending habits, analyze financial health, and evaluate budget limits.

## 2. Project Objectives
The core objectives of this project are to:
* Manage user profiles and their associated bank accounts.
* Record, track, and categorize income and expense transactions.
* Generate automated monthly financial summaries and budget evaluations.
* Maintain a strict, automated audit trail of account balance fluctuations.
* Demonstrate proficiency in advanced SQL features, including **Indexes**, **Views**, **User-Defined Functions**, **Stored Procedures**, **Triggers**, and **Database Backup/Recovery**.

## 3. Main Features
**3.1 User Management:** Add new users and retrieve user lists.
**3.2 Bank Account Management:** Register new accounts, view all accounts, and track current balances per user.
**3.3 Income Management:** Securely insert income transactions and view detailed income history.
**3.4 Expense Management:** Log daily expenses, categorize them, and review expense history.
**3.5 Financial Summary:** Generate monthly reports, view category-wise spending proportions, and check real-time budget status.
**3.6 Balance History Tracking:** Automatically record balance changes (credits/debits) and track historical account fluctuations.
**3.7 Reporting:** Render visual charts (Bar charts for Income vs. Expense, Pie charts for Category Spending).

## 4. Technology Stack
| Component | Technology |
| :--- | :--- |
| **Database Management System** | MySQL 8.x |
| **Database Administration** | MySQL Workbench |
| **Programming Language** | Python 3.x |
| **Database Connector** | `mysql-connector-python` |
| **Data Visualization** | `matplotlib` |
| **Backup & Recovery** | `mysqldump`, `mysql` CLI |

## 5. Project Structure
```text
personal-finance-management-system-main/
├── figures/                            # Execution screenshots and generated charts
├── python/
│   ├── db.py                           # MySQL connection setup (using 'finance_admin')
│   └── main.py                         # Main Python CLI application
├── sql/
│   ├── schema/schema.sql               # DDL for table creation
│   ├── sample_data.sql/sample.sql      # DML for inserting test data
│   ├── index/index.sql                 # Index definitions
│   ├── view.sql/view1.sql              # SQL Views
│   ├── function/                       # Custom SQL Functions
│   ├── procedure/                      # Stored Procedures
│   └── trigger/trigger1.sql            # Automated Triggers
├── PersonalFinanceDB_backup_final.sql  # Full database backup file
├── requirements.txt                    # Python library dependencies
└── README.md                           # Project documentation
```

## 6. File Description
### 6.1 Python Files
* **`python/db.py`**: Establishes the connection to the MySQL database. It uses a dedicated, secure user account (`finance_admin`) to interface with the database.
* **`python/main.py`**: The core application script. It presents a comprehensive 18-option CLI menu, processing user inputs and triggering the corresponding SQL queries or Python visualization functions.

### 6.2 SQL Files
* **`schema.sql`**: Defines the foundational tables (`Users`, `ExpenseCategories`, `BankAccounts`, `Income`, `Expenses`, `BalanceHistory`) along with Primary Keys, Foreign Keys, and Constraints.
* **`sample_data.sql`**: Populates the database with initial mock data for testing purposes.
* **`index.sql`**: Optimizes query performance on frequently searched columns (e.g., Dates, User IDs).
* **`view.sql`**: Pre-compiles complex queries into virtual tables (`MonthlySummaryView`, `CategorySpendingView`, `BalanceHistoryView`) for easier reporting.
* **`function/*.sql`**: Contains scalar functions like `fn_budget_status` to compute real-time logic.
* **`procedure/*.sql`**: Encapsulates transaction insertion logic (`AddIncomeProc`, `AddExpenseProc`).
* **`trigger/*.sql`**: Defines automated actions, such as updating the `BankAccounts` balance and logging the event into `BalanceHistory` upon new transactions.

## 7. Database Design Summary
**Main Tables:** `Users`, `BankAccounts`, `ExpenseCategories`, `Income`, `Expenses`, `BalanceHistory`.
**Key Relationships:**
* 1 User -> N BankAccounts, N Incomes, N Expenses.
* 1 ExpenseCategory -> N Expenses.
* 1 BankAccount -> N Incomes, N Expenses, N BalanceHistory.
* *Note: Every transaction is tied to a specific account, and the balance history table acts as an automated ledger driven by triggers.*

## 8. Advanced SQL Features
* **Indexes:** Implemented on User IDs, Account IDs, and transaction dates to drastically reduce query execution time.
* **Views:** Used to abstract multi-table JOINs and aggregations, providing a simplified layer for Python to fetch report data.
* **Functions:** Deployed to compute dynamic outputs, such as evaluating if a user's spending is nearing their budget limit.
* **Stored Procedures:** Used to parameterize and secure the process of adding financial records.
* **Triggers:** Ensure strict data integrity by automatically updating the current account balance and writing to the audit log simultaneously after any transaction.

## 9. How to Run the Project
**Step 1:** Open the project folder in VS Code or your preferred editor.
**Step 2:** Install required Python libraries by running:
```cmd
pip install -r requirements.txt
```
**Step 3:** Open MySQL Workbench, execute the following script to create the required database user:
```sql
CREATE USER IF NOT EXISTS 'finance_admin'@'localhost' IDENTIFIED BY 'Pfm@2026';
GRANT ALL PRIVILEGES ON PersonalFinanceDB.* TO 'finance_admin'@'localhost';
FLUSH PRIVILEGES;
```
**Step 4:** Initialize the database by importing `PersonalFinanceDB_backup_final.sql`, or manually run the SQL scripts in the `sql/` folder sequentially.
**Step 5:** Navigate to the `python` directory and launch the application:
```cmd
cd python
python main.py
```

## 10. Main CLI Features
The Python CLI application provides the following 18 interactive options:
1. Add Income
2. Add Expense
3. View Monthly Summary
4. View Category-wise Spending
5. Check Budget Status
6. View Users
7. View Categories
8. View Bank Accounts
9. View Income History
10. View Expense History
11. Report: Income vs Expense Chart (Bar Chart)
12. Report: Category Spending Pie Chart
13. Add User
14. Add Bank Account
15. View Accounts by User
16. View Balance History
17. View Current Balance
0. Exit Program

## 11. Validation and Data Integrity
The system implements dual-layer validation to ensure data accuracy:
* **Python-side Validation:** Prevents application crashes by catching `ValueError` (e.g., typing letters instead of numbers) and checks if User IDs and Account IDs exist before allowing transactions.
* **Database-side Validation:** Enforces strict Foreign Key constraints, `ON DELETE CASCADE` rules, and utilizes Triggers to guarantee that the `BalanceHistory` and `BankAccounts` tables always match perfectly.

## 12. Backup and Recovery
* **Backup Command:**
```cmd
mysqldump -u root -p --routines --triggers PersonalFinanceDB > PersonalFinanceDB_backup_final.sql
```
* **Recovery Command:**
```cmd
mysql -u root -p PersonalFinanceDB < PersonalFinanceDB_backup_final.sql
```
*Note: The flags `--routines` and `--triggers` are crucial for ensuring that advanced features like Procedures, Functions, and Triggers are fully backed up.*

## 13. Current Project Status
**Completed:**
* ERD mapping and relational schema creation.
* Table creation and sample data insertion.
* Implementation of Indexes, Views, Functions, Procedures, and Triggers.
* Successful full database backup.
* Python database connection and robust CLI menu logic.
* Matplotlib chart integration and screenshot collection.

**In Progress:**
* Finalizing the academic report documentation.
* Preparing presentation materials.

## 14. Future Work
Potential enhancements for future iterations of this project include:
* Migrating from CLI to a graphical user interface (GUI) or a web-based application (using Flask/Django).
* Implementing predictive analytics to forecast upcoming expenses using machine learning.
* Exporting financial summaries to Excel or PDF formats.
* Integrating real-time banking APIs.

## 15. Conclusion
This project successfully demonstrates the powerful integration of MySQL and Python to build a practical, automated Personal Finance Management System. The database architecture handles structured storage and complex business logic (via Triggers and Functions), while the Python application provides an accessible interface and visual analytics. It serves as a comprehensive showcase of relational database concepts and application development.

---
**Author:** Dinh Quoc Viet
**Institution:** Faculty of Data Science and Artificial Intelligence, National Economics University (NEU)
```
