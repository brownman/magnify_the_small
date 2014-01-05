#!/bin/bash -e 
#http://subsignal.org/doc/AliensBashTutorial.html#4_e
#http://c.learncodethehardway.org/
pushd `dirname $0` > /dev/null
renice 10 -p $$
#flite 'genius'
#chmod +w time
#ls -d -l time
str="$@"
#notify-send "genius:" "$str"
export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader



input="$1"
if [ $# -gt 1 ];then
    shift
    args=( "$@" )
fi


trace "pid: $$"
dir1=$SCRIPT_DIR/time
result='equal'

#clean_file "$file_logger"
show_env(){
    red show_env
    green "MUTE_CHILD: $MUTE_CHILD"
    sleep1 5
}
run(){


    show_env
    if [ "$input" = '' ];then

        trace 'no arguments to genius'
        notify_send1 'SED' 'examples' 



        cmd="sed -n -e '/{$/p'"
        cmd=$( gxmessage $GXMESSAGET -entrytext "$cmd" -title 'update cmd' "input" )

        funcs=`eval "$cmd" $SCRIPT_DIR/tasks/tasker.sh`

        echo "$funcs" > /tmp/funcs.txt
        zenity1 /tmp/funcs.txt

        url='xdg-open http://www.gentoo.org/doc/en/articles/l-sed1.xml'
        notify_send4 'sed examples' "$url" &

    else
        file11=$dir1/$input.sh

        result=$( $file11 "${args[@]}"  )

    fi

    echo "$result"
    #str=$(service cron status)
    #cmd="notify-send1 cron '$str'"
    #every "$cmd" 10
    #

}
run

popd > /dev/null


