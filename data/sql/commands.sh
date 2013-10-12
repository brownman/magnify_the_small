rm ex1.db &
sqlite3 ex1.db < create_table.sql
sqlite3 ex1.db < update_table.sql
sqlite3 ex1.db < select_from_table.sql
