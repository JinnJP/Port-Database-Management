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
    query = f"""
    SELECT
        COLUMN_NAME,
        COLUMN_TYPE,
        COLUMN_KEY
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_SCHEMA = 'src' AND TABLE_NAME = '{src_table}';"""
    cursor.execute(query)
    data = cursor.fetchall()
    column_types = {column[0]: column[1] for column in data}
    column_keys = {column[0]: 'PRIMARY KEY' if column[2] == 'PRI' else 'UNIQUE' if column[2] == 'UNI' else '' for column in data}
    cursor.close()
    return column_types, column_keys


@app.route('/create_table', methods=['POST'])
def create_table():
    data = request.json
    src_table = data['sourceTable']
    src_column = data['sourceColumn']
    dest_table = data['destTable']
    dest_column = data['destColumn']
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    column_types, column_keys = get_column_types(src_table)
    final_query = manage_create_query(src_table, src_column, dest_table, dest_column, column_types, column_keys)
    try:
        for sql in final_query:
            cursor.execute(sql)
        connection.commit()
        return jsonify({'status': 'Table created!', 'query': final_query})
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()

def get_column_names(table_name, database):
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    query = f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}' AND TABLE_SCHEMA = '{database}';"
    cursor.execute(query)
    column_names = cursor.fetchall()
    cursor.close()
    return column_names

@app.route('/select_table', methods=['POST'])
def select_table():
    data = request.json
    database = data['database']
    table_name = data['table']
    limit_row = data['limitRow']
    column_names = get_column_names(table_name, database)
    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    try:
        cursor.execute(f"SELECT * FROM {database}.{table_name} LIMIT {limit_row};")
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
        sql_command_split = sql_command.split(";\n")
        for command in sql_command_split:
            cursor.execute(command)
        result = cursor.fetchall()
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    
    cursor.close()
    connection.close()
    return result

@app.route('/all_table_column', methods=['GET'])
def allTable_allColumn():
    data = {"src": [], "dest": []}

    connection = mysql.connector.connect(**connector())
    cursor = connection.cursor()
    # -- src --
    cursor.execute("USE src")
    cursor.execute("SHOW TABLES FROM src")
    tables = cursor.fetchall()
    for table in tables:
        table_name = table[0]
        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = cursor.fetchall()

        table_data = {"name": table_name, "columns": [column[0] for column in columns]}
        data["src"].append(table_data)
    # -- dest --
    cursor.execute("USE dest")
    cursor.execute("SHOW TABLES FROM dest")
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

