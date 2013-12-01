delay=5
file_locker=/tmp/riddle


run(){


    #local dir_source=$PWD/1/testing/python2/koans
    #local dir='~/magnify_the_small/1/others/CODE/abs-guide-6.5'
    local dir=$SCRIPT_DIR/tasks/abs/source
    local res1=0 
    local res=''
    local line=''
    local cmd=''
    #local line=$(random_line 'abs')
    while :;do


        line=$(random_from_subject1 abs)
        res="$dir/$line"



        #commander  "exec $res"

        cmd="gedit $res"
        commander "$cmd" & 
        messageYN1 'break ?' 'y/n' '' 60 
        res1=$?

        if [ $res1 -eq 1 ];then
            break
        fi

    done
    db update_table riddle true '?' '?' "$line"
    cmd="exec $res"
    update_commander
    commander "$cmd?" & 



    echo 'do_abs'
    #assert_equal_str "do abs"


}
unlocker
