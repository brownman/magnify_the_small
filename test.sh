#!/bin/bash

# about file:
# test first!
#
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 
test_cli_gui_comptability(){
export GUI='true'
echo 'test.sh !'
#result=$()
result1=$( messageYN "title0" "str 01 ")
#echo "echoiiing: $?"
#result1="$?"
#`echo $?`
echo -n "result1: "
cyan "$result1"
}

test_learn_langs(){
#echo 'the start'
#$PLUGINS_DIR/learn_langs.sh RU 13
#$tasks_sh game_essay 

echo 'the  end'
#gedit /tmp/1.txt
}
step1(){

#http://wiki.bash-hackers.org/syntax/expansion/brace
#http://wiki.bash-hackers.org/syntax/start
#eacher '$tasks_sh time_is_limited' 'it should take a while' 
$tasks_sh commitment

}

#play $infile trim 0:00 =0:10 

step1
exit

