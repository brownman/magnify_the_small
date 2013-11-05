file_name=logger.db

file_absolute=$(echo "$file_name-$(date +%m_%d_%Y_%H_%M).db")
dir1=$DATA_DIR/sql
#/tmp/1.txt
#file_from=/tmp/1.txt
host="root@192.168.1.4"


gui1(){
nautilus sftp://$host:2222
}

ssh01(){

ssh -p 2222 $host
}

scp1(){
COMMANDER=true
local cmd="scp  -P 2222 $dir1/$file_name $host:/sdcard/$file_absolute"

commander "$cmd"
}

scp1
#ssh01
gui1
