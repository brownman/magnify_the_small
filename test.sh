#!/bin/bash

# about file:
# test first!
#

pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=$PWD/public/cfg/user.cfg

echo "PWD: $PWD"

. $TIMERTXT_CFG_FILE

sleep1 2




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

test_write_essay(){
    echo ''
    local file=$TODAY_DIR/txt/essay.txt
    touch $file
    local str=''
    while :;do
        str=$( gxmessage $GXMESSAGET -entry -file $file )
        if [ "$str" = '' ];then
            flite 'breaking'
            break
        else
            update_file $file "$str"
            echo01 $str

        fi
    done
}

test_language_times(){
    echo ''
}

test_proxy_before_cfg_function_run(){
    echo ''
}
test_choose_workflow(){
    msg=$( $tasks_sh chooser workflows )
    echo $msg
    echo $?
}

test_return()  
{
    echo 'return test'
    return $1
}
test_return1(){
return_test 27         # o.k.
echo $?                # Returns 27.

}

test_lesson(){
export DEBUG='true'
$tasks_sh learn_langs 
}

test_pick_1(){
$tasks_sh scrap
}

#test_commitment
#$tasks_sh commitment
#write_essay
test_first_menu(){
echo 'parse menu from yaml - the first menu should be pondering'
}
test_xterm(){
xterm 'echo zz;sleep1 5'
}
step1(){

export DEBUG='true'
test_pick_1
}
step1
popd > /dev/null
