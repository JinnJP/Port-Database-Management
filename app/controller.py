def manage_create_query(src_table,src_column,dest_table,dest_column, column_types, column_keys):
    final_query = []
    columns_select = ', '.join(src_column)
    columns_type = [f"{column} {column_types[column]}" for column in src_column if column in column_types]
    result_columns_str = ', '.join(columns_type)
    # Filter columns for PRIMARY KEY
    primary_key_columns = [column for column in src_column if column_keys.get(column) == 'PRIMARY KEY']
    # Filter columns for UNIQUE
    unique_columns = [column for column in src_column if column_keys.get(column) == 'UNIQUE']
    # Generate SQL statements
    key = []
    if primary_key_columns:
        key.append(f'PRIMARY KEY ({", ".join(primary_key_columns)})')
    if unique_columns:
        key.append(f'UNIQUE ({", ".join(unique_columns)})')
    # Combine SQL statements in the final query
    print(key)
    if key:
        final_query.append(f"""CREATE TABLE dest.{dest_table} ({result_columns_str}, {", ".join(key)}) SELECT {columns_select} FROM src.{src_table}""")
    else:
        final_query.append(f"""CREATE TABLE dest.{dest_table} ({result_columns_str}) SELECT {columns_select} FROM src.{src_table}""")
    for src_col, dest_col in zip(src_column, dest_column):
        if src_col != dest_col:
            data_type = column_types[src_col]
            print('data_type= ',data_type)
            final_query.append(f"ALTER TABLE dest.{dest_table} CHANGE COLUMN {src_col} {dest_col} {data_type}")
    
    #Create Trigger
    column_dest = ', '.join(dest_column)
    formatted_values = [f'NEW.{column}' for column in src_column]
    values_string = ', '.join(formatted_values)
    where_conditions = [f'{dest_column} = OLD.{src_column}' for dest_column, src_column in zip(dest_column, src_column)]
    where_clause = ' AND '.join(where_conditions)
    set_string = ', '.join([f'{dest_column} = NEW.{src_column}' for dest_column, src_column in zip(dest_column, src_column)])
    final_query.append(f"""USE src""")
    final_query.append(f"""CREATE TRIGGER insert_{dest_table} AFTER INSERT ON src.{src_table} FOR EACH ROW BEGIN INSERT INTO dest.{dest_table} ({column_dest}) VALUES ({values_string}); END""")
    final_query.append(f"""CREATE TRIGGER delete_{dest_table} AFTER DELETE ON src.{src_table} FOR EACH ROW BEGIN DELETE FROM dest.{dest_table} WHERE {where_clause}; END""")
    final_query.append(f"""CREATE TRIGGER update_{dest_table} AFTER UPDATE ON src.{src_table} FOR EACH ROW BEGIN UPDATE dest.{dest_table} SET {set_string} WHERE {where_clause}; END""")
    # print("final_query = ",final_query)
    return final_query