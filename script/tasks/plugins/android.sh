


gui1(){
nautilus sftp://root@192.168.1.15:2222/
}

ssh01(){

ssh -p 2222 root@192.168.1.15
}

scp1(){
COMMANDER=true
local cmd="scp  -P 2222 /tmp/1.txt root@192.168.1.15:/sdcard/log1.txt"

commander "$cmd"
}

#scp1
ssh01
#gui1
