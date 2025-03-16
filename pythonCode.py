import mysql.connector  
import datetime
def main():
    connection = mysql.connector.connect(
        host="localhost",
        user="root",           
        password="root@12345",
        database="OlistDB"
    )
    if connection.is_connected():
        print("Connected to OlistDB database successfully.")
    try:
        cursor = connection.cursor()
        query = """
        SELECT 
            OrderID,
            CustomerID,
            OrderStatus,
            PurchaseTimestamp
        FROM Orders
        LIMIT 5;
        """
        cursor.execute(query)
        results = cursor.fetchall()

        print("\n--- Olist Orders Report (First 5 Records) ---")
        for row in results:
            print(f"OrderID: {row[0]}, CustomerID: {row[1]}, Status: {row[2]}, PurchaseTimestamp: {row[3]}")

        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"olist_orders_report_{timestamp}.txt"
        with open(filename, 'w', encoding='utf-8') as outfile:
            outfile.write("Olist Orders Report\n")
            outfile.write("-------------------\n")
            for row in results:
                outfile.write(
                    f"OrderID: {row[0]}, "
                    f"CustomerID: {row[1]}, "
                    f"Status: {row[2]}, "
                    f"PurchaseTimestamp: {row[3]}\n"
                )
        print(f"\nReport saved to {filename}")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()
        connection.close()
        print("\nConnection to OlistDB closed.")

if __name__ == "__main__":
    main()
