from flask import Flask, request, jsonify
import mysql.connector
from test_controller import *
app = Flask(__name__)
db_create_table = {
    "src_table" : "car_brand",
    "src_column" : ["car_brand_id"], #many
    "dest_table" : "brand",
    "dest_column" : ["brand_id"] #many
}
# print(type(db_create_table))
# def connector_source():
#     config = {
#         'user': 'root',
#         'password': 'root',
#         'host': 'localhost',
#         'port': '3306',
#         # 'database': 'src'
#     }
#     return config

def connector():
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'localhost',
        'port': '3306',
        # 'database': 'dest'
    }
    return config
def select_dest():
    # Connect to the database
    # print("q", q)
    connection_config = connector()
    connection = mysql.connector.connect(**connection_config)
    try:
        # Create a cursor object to execute queries
        cursor = connection.cursor()
        # Your SELECT query
        query = "SELECT id, name FROM dest.car_brand;"
        # Execute the query
        cursor.execute(query)
        # Fetch all rows
        result = cursor.fetchall()
        print(result)
        return result
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()
      
# Call the select_data function
# select_data()
@app.route('/')
def hello_world():
    return "Hello world!"

@app.route('/select')
def select():
    return select_dest()

@app.route('/create_table', methods=['GET'])
def search():
    src_table = request.args.get("src_table")
    src_column = request.args.getlist("src_column")
    dest_table = request.args.get("dest_table")
    dest_column = request.args.getlist("dest_column")
    create_query = manage_query(src_table,src_column,dest_table,dest_column)
    # created = create_table(create_query)
    connection_config = connector()
    connection = mysql.connector.connect(**connection_config)
    try:
        # Create a cursor object to execute queries
        cursor = connection.cursor()
        # Execute the query 
        cursor.execute(create_query)
        # result = cursor.fetchall()
        return "Table created!"
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()

if __name__ == '__main__':
    # app.run(host='0.0.0.0')
    app.run(host='0.0.0.0', port=4999, debug=True)

