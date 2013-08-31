#!/bin/bash

# about file:
# test first!
#

pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=public/cfg/user.cfg
echo "PWD: $PWD"
. $TIMERTXT_CFG_FILE
export DEBUG='true'
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
test_menus(){
echo ''
local msg=$($tasks_sh chooser sleeper)
#eval "do_$msg"
echo $msg
}
test_parse(){
#$tasks_sh present achivements 

parse_from frame.now 
}
test_take_picture(){
$tasks_sh take_photo
}

test_article_translation(){
echo ''
}
test_recent_step(){
$tasks_sh recent_step
}
test_plugin_yaml_parser(){
#present frame.self
$tasks_sh present frame.mantra
}
test_essay(){
$tasks_sh write_essay
}

test_suspend(){
$tasks_sh suspend1

}
test_workflow_generation(){
echo ''
$tasks_sh generate_file workflow $CFG_DIR/workflow.cfg
}
test_python_koans_test_shell_also(){
echo ''
}


step1(){
#test_take_picture
#test_recent_step study

#$tasks_sh commitment 
#test_suspend
#test_workflow_generation
#eacher "$tasks_sh show sport" 'abc' 'def'
#$tasks_sh show sport
eacher "$tasks_sh show sport"  "desc ?" "1" "task: count/max" 
echo "result: $?"
}

step1
popd > /dev/null
