#! /usr/bin/env bash
#Read from a sqlite3 database and build a zenity list
#to represent the table

command='--list --title="Database memos" '
header=`sqlite -header -list test.db 'select * from memos;' | head -n 1`

IFS='|' read -a columns <<< "$header"

for col in ${columns[@]}; do
   command="$command --column=\"$col\" "
done

command="$command $(sqlite -csv test.db 'select * from memos;' | tr ',' ' ') "

echo "$command" | tr '\n' ' ' | xargs zenity
