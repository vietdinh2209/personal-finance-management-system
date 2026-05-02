import mysql.connector
import matplotlib.pyplot as plt

# 1. Hàm kết nối Database
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Vietdq.22092006",
        database="personalfinancedb"
    )

# 2. Hàm lấy dữ liệu và vẽ biểu đồ Thu - Chi (Bar Chart)
def plot_income_vs_expense(user_id, month, year):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Lấy tổng thu
    cursor.execute("SELECT IFNULL(SUM(Amount), 0) FROM Income WHERE UserID=%s AND MONTH(IncomeDate)=%s AND YEAR(IncomeDate)=%s", (user_id, month, year))
    total_income = float(cursor.fetchone()[0])

    # Lấy tổng chi
    cursor.execute("SELECT IFNULL(SUM(Amount), 0) FROM Expenses WHERE UserID=%s AND MONTH(ExpenseDate)=%s AND YEAR(ExpenseDate)=%s", (user_id, month, year))
    total_expense = float(cursor.fetchone()[0])
    
    conn.close()

    labels = ['Income', 'Expense']
    amounts = [total_income, total_expense]
    colors = ['#1f77b4', '#ff7f0e']

    plt.figure(figsize=(8, 6))
    plt.bar(labels, amounts, color=colors)
    plt.title(f'Income vs Expense for User {user_id} in {month}/{year}')
    plt.ylabel('Amount (VND)')
    plt.show()

# 3. Hàm lấy dữ liệu và vẽ biểu đồ Tròn chi tiêu theo danh mục (Pie Chart)
def plot_category_spending(user_id, month, year):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Truy vấn tính tổng chi tiêu gom nhóm theo tên danh mục
    query = """
        SELECT c.CategoryName, SUM(e.Amount) 
        FROM Expenses e 
        JOIN ExpenseCategories c ON e.CategoryID = c.CategoryID 
        WHERE e.UserID=%s AND MONTH(e.ExpenseDate)=%s AND YEAR(e.ExpenseDate)=%s 
        GROUP BY c.CategoryName
    """
    cursor.execute(query, (user_id, month, year))
    results = cursor.fetchall()
    conn.close()

    if not results:
        print("Không có dữ liệu chi tiêu cho tháng này!")
        return

    categories = [row[0] for row in results]
    spending = [float(row[1]) for row in results]

    plt.figure(figsize=(8, 8))
    plt.pie(spending, labels=categories, autopct='%1.1f%%', startangle=90)
    plt.title(f'Category-wise Spending for User {user_id} - {month}/{year}')
    plt.show()

# 4. Giao diện Menu (CLI)
def main():
    while True:
        print("\n===== PERSONAL FINANCE MANAGEMENT SYSTEM =====")
        print("1. Add Income")
        print("2. Add Expense")
        print("11. Report: Income vs Expense Chart")
        print("12. Report: Category Spending Pie Chart")
        print("18. Exit")
        
        choice = input("Enter your choice: ")
        
        if choice == '11':
            # Vẽ biểu đồ cho UserID 1 (Việt), tháng 4 năm 2026
            plot_income_vs_expense(1, 4, 2026)
        elif choice == '12':
            # Vẽ biểu đồ tròn cho UserID 1 (Việt), tháng 4 năm 2026
            plot_category_spending(1, 4, 2026)
        elif choice == '18':
            print("Exiting program...")
            break
        else:
            print("Feature coming soon!")

if __name__ == "__main__":
    main()