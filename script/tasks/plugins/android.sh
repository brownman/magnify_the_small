file_name=logger.db
dir1=$DATA_DIR/sql
#/tmp/1.txt
#file_from=/tmp/1.txt


gui1(){
nautilus sftp://root@192.168.1.15:2222/sdcard
}

ssh01(){

ssh -p 2222 root@192.168.1.15
}

scp1(){
COMMANDER=true
local cmd="scp  -P 2222 $dir1/$file_name root@192.168.1.15:/sdcard/$file_name"

commander "$cmd"
}

scp1
#ssh01
gui1
