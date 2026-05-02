import mysql.connector

def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",
        user="finance_admin",   # Tài khoản mới chuyên nghiệp
        password="Pfm@2026",    # Mật khẩu mới
        database="PersonalFinanceDB"
    )
    return connection

if __name__ == "__main__":
    try:
        conn = get_db_connection()
        print("Connected to MySQL successfully with 'finance_admin' account!")
        conn.close()
    except mysql.connector.Error as err:
        print(f"Error: {err}")