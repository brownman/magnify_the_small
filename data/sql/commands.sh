
#sqlite3 ex1.db '.dump' | grep -vE '^(BEGIN|COMMIT|CREATE|DELETE)|"sqlite_sequence"' | sed -r 's/"([^"]+)"/`\1`/' | tee mydb.sql
dir1=$PWD/backup
mkdir -p $dir1

db_file=$(echo $dir1/ex1-$(date +%m_%d_%Y_%H_%M).db)
mv ex1.db $db_file
sqlite3 ex1.db < create_table.sql
sqlite3 ex1.db < update_table.sql
sqlite3 ex1.db < select_from_table.sql


