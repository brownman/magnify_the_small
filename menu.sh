export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh

. $file_loader
result=$SUCCESS
export COMMANDER=false

menu(){
local choose=$(zenity1 $file_menu status mission)
#local choose='abc'
if [ "$choose" != '' ];then

    /usr/bin/xterm -e "$TIME_DIR/${choose}.sh" &
    #/usr/bin/xterm -e "echo hi;sleep 5" &
    #$TIME_DIR/${choose}.sh" &
fi
echo 'end'

}




loop(){
while :;do
    menu
    $tasks_sh motivation glossary
    sleep1 5

done
}

run(){
      loop
}

run
