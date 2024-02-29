# Example usage
src_table = "car_brand"
dest_table = "car_brand"

# src_column = ['car_brand_id']
# src_column = ['car_brand_id', 'car_brand_name']
# dest_column = ['id', 'name']

src_column = ['car_brand_id', 'car_brand_name']
dest_column = ['id', 'name']
column_types = {
    'car_brand_id': 'char(2)',
    'car_brand_name': 'varchar(20)',
    # ... Other columns and their data types
}

def manage_create_query(src_table,src_column,dest_table,dest_column, column_types):
    print('column_types= ',column_types)
    columns_str = ', '.join(src_column)
    create_query = []
    create_query.append(f"""CREATE TABLE dest.{dest_table} AS SELECT {columns_str} FROM src.{src_table}""")
    for src_col, dest_col in zip(src_column, dest_column):
        if src_col != dest_col:
            data_type = column_types[src_col]
            print('data_type= ',data_type)
            create_query.append(f"ALTER TABLE dest.{dest_table} CHANGE COLUMN {src_col} {dest_col} {data_type}")
    print("create_query = ",create_query)
    return create_query

# manage_create_query(src_table,src_column,dest_table,dest_column, column_types)



# sql_statements = ['CREATE TABLE dest.car_brand AS SELECT car_brand_id, car_brand_name FROM src.car_brand', 'ALTER TABLE dest.car_brand RENAME COLUMN car_brand_id TO id', 'ALTER TABLE dest.car_brand RENAME COLUMN car_brand_name TO name']
# for sql in sql_statements:
#     # cursor.execute(sql)
#     print(f"Executed SQL: {sql};")