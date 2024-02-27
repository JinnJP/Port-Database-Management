from flask import Flask, jsonify, request
from controller import * 
import mysql.connector

app = Flask(__name__)

def connector():
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        # 'database': 'dest','src'
    }
    return config

@app.route('/car_brand')
def index():
    # config_db = connector_sql()
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM src.car_brand')
    results = cursor.fetchall()
    cursor.close()
    connection.close()
    return results

@app.route('/select_dest')
def select_dest():
    connection_config = connector()
    connection = mysql.connector.connect(**connection_config)
    try:
        # Create a cursor object to execute queries
        cursor = connection.cursor()
        # Your SELECT query
        query = "SELECT * FROM dest.car_brand;"
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
        # cursor.execute(create_query, multi=True)
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

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    # app.run(host='0.0.0.0')
    app.run(host='0.0.0.0', port=5000, debug=True)

