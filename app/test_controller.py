# Example usage
# src_table = "car_brand"
# src_column = ['car_brand_id']
# src_column = ['car_brand_id', 'car_brand_name']
# dest_column = ['id', 'name']

# src_column = ['car_brand_id', 'car_brand_name']
# dest_column = ['id', 'name']
from flask import jsonify
import mysql.connector
def connector():
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'localhost',
        'port': '3306',
        # 'database': 'src'
    }
    return config
def create_table(create_query):
    connection_config = connector()
    connection = mysql.connector.connect(**connection_config)
    try:
        # Create a cursor object to execute queries
        cursor = connection.cursor()
        # Execute the query 
        cursor.execute(create_query)
        result = cursor.fetchall()
        return jsonify(result)
    except mysql.connector.Error as err:
        # Handle the error and return a JSON response
        error_message = str(err)
        return jsonify({'error': error_message})
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()

def select_table(select_query):
    connection_config = connector()
    connection = mysql.connector.connect(**connection_config)
    try:
        # Create a cursor object to execute queries
        cursor = connection.cursor()
        # Execute the query 
        cursor.execute(select_query)
        result = cursor.fetchall()
        print(result)
        return result
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()
def manage_query(src_table,src_column,dest_table,dest_column):
    # print("create_sql=",src_table,src_column)
    # print(src_table, type(src_table))

    # print(src_column, type(src_column))
    # src_column = ['car_brand_id', 'car_brand_name']
    # src_column = ['car_brand_id']
    columns_str = ', '.join(src_column)
    dest_column_str = ', '.join(dest_column)
    create_query = f"""CREATE TABLE dest.{dest_table} AS SELECT {columns_str} FROM src.{src_table};"""
    for src_col, dest_col in zip(src_column, dest_column):
        if src_col != dest_col:
            create_query += f"\nALTER TABLE dest.{dest_table} RENAME COLUMN {src_col} TO {dest_col};"
            # print(f"ALTER TABLE dest.brand RENAME COLUMN {src_col} TO {dest_col};")
    # print(query)
    # select_query = f"\nSELECT {dest_column_str} FROM dest.{dest_table};"
    return create_query

# select_src(src_table,src_column)
    
# CREATE TABLE dest.brand1 AS SELECT car_brand_id FROM src.car_brand;
# ALTER TABLE dest.brand1 RENAME COLUMN car_brand_id TO id;