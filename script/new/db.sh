#!/bin/bash
#http://code.google.com/p/linuxsleuthing//browse/nautilus-scripts/

# variables
dir=$PWD/data/db
file_db=$dir/test.db 

table1=memos
#touch $file_log
SUCCESS=1
FAILURE=0

to_mysql(){
sqlite3 mydb.sqlite3 '.dump' | grep -vE '^(BEGIN|COMMIT|CREATE|DELETE)|"sqlite_sequence"' | sed -r 's/"([^"]+)"/`\1`/' | tee mydb.sql | mysql -p mydb
}

store(){
#Read from a sqlite3 database and build a zenity list
#to represent the table
command='--list --title="Database memos" '
header=`sqlite3 -header -list $file_db "select * from $table1;" | head -n 1`
IFS='|' read -a columns <<< "$header"
for col in ${columns[@]}; do
   command="$command --column=\"$col\" "
done
command="$command $(sqlite3 -csv $file_db 'select * from memos;' | tr ',' ' ') "
echo "$command" | tr '\n' ' ' | xargs zenity
}

update(){
zenity --forms --title="Create user" --text="Add new user" \
   --add-entry="First Name" \
   --add-entry="Last Name" \
   --add-entry="Username" \
   --add-password="Password" \
   --add-password="Confirm Password" \
   --add-calendar="Expires"
}
update1(){
#echo "im gonna run" sqlite3 tasks.db "insert into todo \
     #(project,duedate,status,description) \
     #values (\"$Proj\",$Due,\"$Stat\",\"$Descr\");"

#sqlite3 tasks.db "insert into todo (project,duedate,status,description) \
         #values (\"$Proj\",$Due,\"$Stat\",\"$Descr\");"

local task='new task1'
local priority=4
sqlite3 $file_db "insert into $table1 (priority,task) \
         values ($priority,\"$task\");"
}


from_firefox(){
TITLE="Show Contents"

# query for table name
TEXT=$(echo -e "Available Tables:\n\n$(sqlite3 "$@" ".table" | tr -s ' ' '\n')\n\nEnter table to view:")
SELECTION=$(zenity --entry \
	--title "$TITLE" \
	--text "$TEXT")
	
# output table contents
OUTPUT=$(sqlite3 "$@" "select * from "$SELECTION"")
echo "$OUTPUT" | \
	zenity --text-info \
		--title "$TITLE" \
		--width=640 \
		--height=480

# search option
zenity --question \
	--title $TITLE \
	--text "Do you want to search this output?" \
	--ok-label="Yes" \
	--cancel-label="No"
	
if [ "$?" = "1" ]; then
	exit 0
fi

TERM=$(zenity --entry \
	--title "$TITLE" \
	--text "Enter search term:")
echo -e "$OUTPUT" | grep -Ei "$TERM" | \
	zenity --text-info \
		--title "$TITLE" \
		--width=640 \
		--height=480
		
}

exit 0
