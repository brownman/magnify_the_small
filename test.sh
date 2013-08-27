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

test_default(){
    w1=${1:-'ss'}   # Defaults to /tmp dir.
    echo "w1: $w1"
}

func1() {
echo 'func1'
#echo 'abc'
#return 11
}

func2(){
func1
res11=$?
echo "$res11"
}

$tasks_sh recent we
#echo $?
