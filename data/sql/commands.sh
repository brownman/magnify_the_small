

dir1=$PWD/backup
name1=ex02
file_name="$name1.db"

touch $file_name
mkdir -p $dir1
file_absolute=$(echo "$dir1/$name1-$(date +%m_%d_%Y_%H_%M).db")
mv $file_name $file_absolute &

sqlite3 $file_name < create_table.sql
sqlite3 $file_name < update_table.sql
sqlite3 $file_name < select_from_table.sql


