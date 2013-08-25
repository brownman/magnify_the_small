#!/bin/bash

# about file:
# test first!
#
export TIMERTXT_CFG_FILE=public/cfg/user.cfg
. $TIMERTXT_CFG_FILE
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
    #$tasks_sh commitment
    #$tasks_sh remind_me1
    #$tasks_sh recent_steps 
    #$tasks_sh edit essay_aday 

   # $tasks_sh reminder 
    #$tasks_sh learn_langs 
    #show guidance 
    #$tasks_sh motivation sport 

    #local aa=$( $tasks_sh chooser workflows )
    #echo $aa
$tasks_sh chooser workflows
#  local route=$($tasks_sh chooser workflows)
#  local result=$?
#            echo "route is: $route"
#
#            echo "result is: $result"
#            #local route='motivation'
}


step2(){
msg2="a b cc"
$( messageYN  "$msg2" )
echo $?
}
step3(){
w1=${1:-'ss'}   # Defaults to /tmp dir.
echo "w1: $w1"
}

step1


#step1
#hello='ab ccd'
#gxmessage $GXMESSAGET "$hello" -buttons "ok:2,cancel:1"
#exit
#play $infile trim 0:00 =0:10 
#step1
#$tasks_sh "$1" "$2" "$3"
#messageYN 
