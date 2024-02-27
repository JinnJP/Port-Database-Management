def manage_query(src_table,src_column,dest_table,dest_column):
    columns_str = ', '.join(src_column)
    # dest_column_str = ', '.join(dest_column)
    create_query = f"""CREATE TABLE dest.{dest_table} AS SELECT {columns_str} FROM src.{src_table};"""
    for src_col, dest_col in zip(src_column, dest_column):
        if src_col != dest_col:
            create_query += f"\nALTER TABLE dest.{dest_table} RENAME COLUMN {src_col} TO {dest_col};"
    # select_query = f"\nSELECT {dest_column_str} FROM dest.{dest_table};"
    return create_query