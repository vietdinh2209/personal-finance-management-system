from db import get_db_connection
import mysql.connector
import matplotlib.pyplot as plt

def add_income():
    try:
        user_id = int(input("Enter User ID: "))
        account_id = int(input("Enter Account ID: "))
        amount = float(input("Enter amount: "))
        income_date = input("Enter income date (YYYY-MM-DD): ")
        description = input("Enter description: ")

        conn = get_db_connection()
        cursor = conn.cursor()

        check_query = "SELECT UserID FROM BankAccounts WHERE AccountID = %s"
        cursor.execute(check_query, (account_id,))
        result = cursor.fetchone()

        if not result:
            print("Error: Account ID does not exist.")
            return
        elif result[0] != user_id:
            print(f"Error: Account ID {account_id} does not belong to User ID {user_id}.")
            return

        cursor.callproc("AddIncomeProc", [user_id, account_id, amount, income_date, description])
        conn.commit()

        print("Income added successfully!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input. Please enter the correct data type.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def add_expense():
    try:
        user_id = int(input("Enter User ID: "))
        category_id = int(input("Enter Category ID: "))
        account_id = int(input("Enter Account ID: "))
        amount = float(input("Enter amount: "))
        expense_date = input("Enter expense date (YYYY-MM-DD): ")
        description = input("Enter description: ")

        conn = get_db_connection()
        cursor = conn.cursor()

        check_query = "SELECT UserID FROM BankAccounts WHERE AccountID = %s"
        cursor.execute(check_query, (account_id,))
        result = cursor.fetchone()

        if not result:
            print("Error: Account ID does not exist.")
            return
        elif result[0] != user_id:
            print(f"Error: Account ID {account_id} does not belong to User ID {user_id}.")
            return

        cursor.callproc("AddExpenseProc", [user_id, category_id, account_id, amount, expense_date, description])
        conn.commit()

        print("Expense added successfully!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input. Please enter the correct data type.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def view_monthly_summary():
    try:
        user_id = int(input("Enter User ID: "))
        year = int(input("Enter year: "))
        month = int(input("Enter month: "))

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT UserName, TotalIncome, Month, Year
        FROM MonthlySummaryView
        WHERE UserName = (SELECT UserName FROM Users WHERE UserID = %s) AND Year = %s AND Month = %s
        """
        cursor.execute(query, (user_id, year, month))
        result = cursor.fetchall()

        if result:
            print("\nMonthly Summary:")
            for row in result:
                print(f"UserName: {row[0]}")
                print(f"Year: {row[3]}")
                print(f"Month: {row[2]}")
                print(f"Total Income: {row[1]}")
                print("-" * 40)
        else:
            print("No summary data found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def view_category_spending():
    try:
        year = int(input("Enter year: "))
        month = int(input("Enter month: "))

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT CategoryName, TotalSpent
        FROM CategorySpendingView
        WHERE SpendingYear = %s AND SpendingMonth = %s
        """
        cursor.execute(query, (year, month))
        result = cursor.fetchall()

        if result:
            print("\nCategory-wise Spending:")
            for row in result:
                print(f"Category: {row[0]} | Total Expense: {row[1]}")
        else:
            print("No category spending data found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def check_budget_status():
    try:
        user_id = int(input("Enter User ID: "))
        year = int(input("Enter year: "))
        month = int(input("Enter month: "))
        budget_limit = float(input("Enter budget limit: "))

        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT fn_budget_status(%s, %s, %s, %s)"
        cursor.execute(query, (user_id, year, month, budget_limit))
        result = cursor.fetchone()

        if result:
            print(f"Budget Status: {result[0]}")
        else:
            print("Could not determine budget status.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()

def view_users():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT UserID, UserName, Email, PhoneNumber FROM Users"
        cursor.execute(query)
        result = cursor.fetchall()

        if result:
            print("\n===== USERS =====")
            for row in result:
                print(f"UserID: {row[0]} | Name: {row[1]} | Email: {row[2]} | Phone: {row[3]}")
        else:
            print("No users found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def view_categories():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT CategoryID, CategoryName FROM ExpenseCategories ORDER BY CategoryID"
        cursor.execute(query)
        result = cursor.fetchall()

        if result:
            print("\n===== EXPENSE CATEGORIES =====")
            for row in result:
                print(f"CategoryID: {row[0]} | CategoryName: {row[1]}")
        else:
            print("No categories found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def view_bank_accounts():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT b.AccountID, u.UserName, b.BankName, b.Balance
        FROM BankAccounts b
        JOIN Users u ON b.UserID = u.UserID
        """
        cursor.execute(query)
        result = cursor.fetchall()

        if result:
            print("\n===== BANK ACCOUNTS =====")
            for row in result:
                print(f"AccountID: {row[0]} | User: {row[1]} | Bank: {row[2]} | Balance: {row[3]}")
        else:
            print("No bank accounts found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()

def view_income_history():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT i.IncomeID, u.UserName, b.BankName, i.Amount, i.IncomeDate, i.Description
        FROM Income i
        JOIN Users u ON i.UserID = u.UserID
        JOIN BankAccounts b ON i.AccountID = b.AccountID
        ORDER BY i.IncomeID
        """
        cursor.execute(query)
        result = cursor.fetchall()

        if result:
            print("\n===== INCOME HISTORY =====")
            for row in result:
                print(f"IncomeID: {row[0]} | User: {row[1]} | Bank: {row[2]} | Amount: {row[3]} | Date: {row[4]} | Desc: {row[5]}")
        else:
            print("No income records found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def view_expense_history():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT e.ExpenseID, u.UserName, c.CategoryName, b.BankName, e.Amount, e.ExpenseDate, e.Description
        FROM Expenses e
        JOIN Users u ON e.UserID = u.UserID
        JOIN ExpenseCategories c ON e.CategoryID = c.CategoryID
        JOIN BankAccounts b ON e.AccountID = b.AccountID
        ORDER BY e.ExpenseID
        """
        cursor.execute(query)
        result = cursor.fetchall()

        if result:
            print("\n===== EXPENSE HISTORY =====")
            for row in result:
                print(f"ExpenseID: {row[0]} | User: {row[1]} | Category: {row[2]} | Bank: {row[3]} | Amount: {row[4]} | Date: {row[5]} | Desc: {row[6]}")
        else:
            print("No expense records found.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()

def report_income_vs_expense_chart():
    try:
        user_id = int(input("Enter User ID: "))
        year = int(input("Enter year: "))

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT IFNULL(SUM(Amount), 0) FROM Income WHERE UserID=%s AND YEAR(IncomeDate)=%s", (user_id, year))
        total_income = float(cursor.fetchone()[0])

        cursor.execute("SELECT IFNULL(SUM(Amount), 0) FROM Expenses WHERE UserID=%s AND YEAR(ExpenseDate)=%s", (user_id, year))
        total_expense = float(cursor.fetchone()[0])
        
        if total_income == 0 and total_expense == 0:
            print("No data found for this year.")
            return

        labels = ['Income', 'Expense']
        amounts = [total_income, total_expense]
        colors = ['#1f77b4', '#ff7f0e']

        plt.figure(figsize=(8, 6))
        plt.bar(labels, amounts, color=colors)
        plt.title(f'Total Income vs Expense for User {user_id} in {year}')
        plt.ylabel('Amount (VND)')
        plt.show()

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()

def report_category_pie_chart():
    try:
        user_id = int(input("Enter User ID: "))
        year = int(input("Enter year: "))
        month = int(input("Enter month: "))

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT c.CategoryName, SUM(e.Amount) 
        FROM Expenses e 
        JOIN ExpenseCategories c ON e.CategoryID = c.CategoryID 
        WHERE e.UserID=%s AND MONTH(e.ExpenseDate)=%s AND YEAR(e.ExpenseDate)=%s 
        GROUP BY c.CategoryName
        """
        cursor.execute(query, (user_id, month, year))
        result = cursor.fetchall()

        if not result:
            print("No category spending data found.")
            return

        categories = [row[0] for row in result]
        amounts = [float(row[1]) for row in result]

        plt.figure(figsize=(8, 8))
        plt.pie(amounts, labels=categories, autopct='%1.1f%%', startangle=90)
        plt.title(f"Category-wise Spending for User {user_id} - {month}/{year}")
        plt.tight_layout()
        plt.show()

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()

def user_exists(user_id):
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT UserID FROM Users WHERE UserID = %s"
        cursor.execute(query, (user_id,))
        result = cursor.fetchone()

        return result is not None

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def account_exists(account_id):
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT AccountID FROM BankAccounts WHERE AccountID = %s"
        cursor.execute(query, (account_id,))
        result = cursor.fetchone()

        return result is not None

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def add_user():
    conn = None
    cursor = None
    try:
        user_name = input("Enter user name: ").strip()
        email = input("Enter email: ").strip()
        phone_number = input("Enter phone number: ").strip()

        if not user_name:
            print("Error: User name cannot be empty.")
            return

        if not email:
            print("Error: Email cannot be empty.")
            return

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO Users (UserName, Email, PhoneNumber)
        VALUES (%s, %s, %s)
        """
        cursor.execute(query, (user_name, email, phone_number))
        conn.commit()

        print("User added successfully!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def add_bank_account():
    conn = None
    cursor = None
    try:
        user_id = int(input("Enter User ID: "))
        bank_name = input("Enter bank name: ").strip()
        balance = float(input("Enter initial balance: "))

        if not user_exists(user_id):
            print("Error: User ID does not exist.")
            return

        if not bank_name:
            print("Error: Bank name cannot be empty.")
            return

        if balance < 0:
            print("Error: Initial balance cannot be negative.")
            return

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO BankAccounts (UserID, BankName, Balance)
        VALUES (%s, %s, %s)
        """
        cursor.execute(query, (user_id, bank_name, balance))
        conn.commit()

        print("Bank account added successfully!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def view_accounts_by_user():
    conn = None
    cursor = None
    try:
        user_id = int(input("Enter User ID: "))

        if not user_exists(user_id):
            print("Error: User ID does not exist.")
            return

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT b.AccountID, u.UserName, b.BankName, b.Balance
        FROM BankAccounts b
        JOIN Users u ON b.UserID = u.UserID
        WHERE b.UserID = %s
        ORDER BY b.AccountID ASC
        """
        cursor.execute(query, (user_id,))
        result = cursor.fetchall()

        if result:
            print("\n===== BANK ACCOUNTS OF USER =====")
            for row in result:
                print(f"AccountID: {row[0]} | User: {row[1]} | Bank: {row[2]} | Balance: {row[3]}")
        else:
            print("This user has no bank accounts.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def view_balance_history():
    conn = None
    cursor = None
    try:
        account_id = int(input("Enter Account ID: "))

        if not account_exists(account_id):
            print("Error: Account ID does not exist.")
            return

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT HistoryID, UserName, BankName, ChangeType, AmountChanged,
               BalanceBefore, BalanceAfter, ChangedAt, ReferenceType, ReferenceID, Description
        FROM BalanceHistoryView
        WHERE AccountID = %s
        ORDER BY ChangedAt DESC, HistoryID DESC
        """
        cursor.execute(query, (account_id,))
        result = cursor.fetchall()

        if result:
            print("\n===== BALANCE HISTORY =====")
            for row in result:
                print(
                    f"HistoryID: {row[0]} | User: {row[1]} | Bank: {row[2]} | "
                    f"Type: {row[3]} | Amount: {row[4]} | "
                    f"Before: {row[5]} | After: {row[6]} | "
                    f"At: {row[7]} | RefType: {row[8]} | RefID: {row[9]} | Desc: {row[10]}"
                )
        else:
            print("No balance history found for this account.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def view_current_balance():
    conn = None
    cursor = None
    try:
        account_id = int(input("Enter Account ID: "))

        if not account_exists(account_id):
            print("Error: Account ID does not exist.")
            return

        conn = get_db_connection()
        cursor = conn.cursor()

        query = "SELECT fn_current_balance(%s)"
        cursor.execute(query, (account_id,))
        result = cursor.fetchone()

        if result:
            print(f"Current Balance of Account {account_id}: {result[0]}")
        else:
            print("Could not retrieve current balance.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError:
        print("Invalid input.")
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()


def show_menu():
    print("\n===== PERSONAL FINANCE MANAGEMENT SYSTEM =====")
    print("1. Add Income")
    print("2. Add Expense")
    print("3. View Monthly Summary")
    print("4. View Category-wise Spending")
    print("5. Check Budget Status")
    print("6. View Users")
    print("7. View Categories")
    print("8. View Bank Accounts")
    print("9. View Income History")
    print("10. View Expense History")
    print("11. Report: Income vs Expense Chart")
    print("12. Report: Category Spending Pie Chart")
    print("13. Add User")
    print("14. Add Bank Account")
    print("15. View Accounts by User")
    print("16. View Balance History")
    print("17. View Current Balance")
    print("0. Exit")


def main():
    while True:
        show_menu()
        choice = input("Enter your choice: ")

        if choice == "1":
            add_income()
        elif choice == "2":
            add_expense()
        elif choice == "3":
            view_monthly_summary()
        elif choice == "4":
            view_category_spending()
        elif choice == "5":
            check_budget_status()
        elif choice == "6":
            view_users()
        elif choice == "7":
            view_categories()
        elif choice == "8":
            view_bank_accounts()
        elif choice == "9":
            view_income_history()
        elif choice == "10":
            view_expense_history()
        elif choice == "11":
            report_income_vs_expense_chart()
        elif choice == "12":
            report_category_pie_chart()
        elif choice == "13":
            add_user()
        elif choice == "14":
            add_bank_account()
        elif choice == "15":
            view_accounts_by_user()
        elif choice == "16":
            view_balance_history()
        elif choice == "17":
            view_current_balance()
        elif choice == "0":
            print("Exiting program...")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()