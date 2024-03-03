from flask import Flask, jsonify, request
from flask_cors import CORS
from controller import * 
import mysql.connector

app = Flask(__name__)
CORS(app)

def connector():
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        # 'database': 'dest','src'
    }
    return config

def get_column_types(src_table):
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    query = f"DESCRIBE src.{src_table};"
    cursor.execute(query)
    column_types = {column[0]: column[1] for column in cursor.fetchall()}
    cursor.close()
    return column_types

@app.route('/create_table', methods=['POST'])
def create_table():
    data = request.json
    src_table = data['sourceTable']
    src_column = data['sourceColumn']
    dest_table = data['destTable']
    dest_column = data['destColumn']
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    column_types = get_column_types(src_table)
    sql_statements = manage_create_query(src_table, src_column, dest_table, dest_column, column_types)
    try:
        for sql in sql_statements:
            cursor.execute(sql)
        connection.commit()
        return jsonify({'status': 'Table created!', 'query': sql_statements})
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()  

def get_column_names(table_name):
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    query = f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}' AND TABLE_SCHEMA = 'src';"
    cursor.execute(query)
    column_names = cursor.fetchall()
    cursor.close()
    return column_names

@app.route('/select_table', methods=['POST'])
def select_table():
    data = request.json
    table_name = data['table']
    column_names = get_column_names(table_name)
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    try:
        cursor.execute(f"SELECT * FROM src.{table_name} LIMIT 5;")
        data = cursor.fetchall()
        formatted_data = [dict(zip([col[0] for col in column_names], row)) for row in data]
        if len(formatted_data) != 0:
            return formatted_data
        else:
            return 'Query returned no results.'
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()  

@app.route('/manual_sql', methods=['POST'])
def manual_sql():
    data = request.json
    sql_command = data['sql']
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()

    try:
        cursor.execute(sql_command)
        result = cursor.fetchall()
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    
    cursor.close()
    connection.close()
    return result

#!Route for testing
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
    # connection_config = connector()
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    try:
        # Create a cursor object to execute queries
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

@app.route('/desc_dest')
def desc_dest():
    dest_table = request.args.get("dest_table")
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    query = f"DESCRIBE dest.{dest_table};"
    cursor.execute(query)
    column_types = {column[0]: column[1] for column in cursor.fetchall()}
    # result = cursor.fetchall()
    cursor.close()
    return column_types

@app.route('/desc_src', methods=['GET'])
def desc_src():
    src_table = request.args.get("src_table")
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    query = f"DESCRIBE src.{src_table};"
    cursor.execute(query)
    # column_types = {column[0]: column[1] for column in cursor.fetchall()}
    results = cursor.fetchall()
    cursor.close()
    # return jsonify({'result': result,'column_types': column_types})
    return results

@app.route('/all_table_column', methods=['GET'])
def all_table_column():
    host = "db"
    user = "root"
    password = "root"
    port = "3306"
    database_src = "src"
    database_dest = "dest"

    data = {"source": [], "dest": []}

    # -- src ---
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        port=port,
        database=database_src)
    cursor = connection.cursor()
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    for table in tables:
        table_name = table[0]
        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = cursor.fetchall()

        table_data = {"name": table_name, "columns": [column[0] for column in columns]}
        data["source"].append(table_data)
    cursor.close()
    connection.close()

    # -- dest ---
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        port=port,
        database=database_dest)
    cursor = connection.cursor()
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    for table in tables:
        table_name = table[0]
        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = cursor.fetchall()

        table_data = {"name": table_name, "columns": [column[0] for column in columns]}
        data["dest"].append(table_data)
    cursor.close()
    connection.close()

    return data

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4999, debug=True)

