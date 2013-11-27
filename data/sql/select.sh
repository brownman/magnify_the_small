table=$1
sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db "select * from $table order by id desc;"
#sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;'
