delay=5
file_locker=/tmp/riddle

dir=''
subject=''
delay1=$delay_riddle
notify_send1 delay "$delay1"

random_path(){
        dir=$SCRIPT_DIR/tasks/abs/source
        subject=abs

        
        filename=$(random_from_subject1 $subject)

        full_path=$dir/$filename

}
#    else
#        dir=~/magnify_the_small/1/bash-bash-4.3-testing/tests
#        subject=bash
#
#        filename=$(random_from_subject1 $subject)
#       mkdir -p $dir/tmp 
#        cp $dir/$filename $dir/tmp/$filename.sh
#
#        #full_path=$dir/$filename
#full_path=$dir/tmp/$filename.sh
#
#
#    fi





run(){

    notify_send1 'riddle' 'bash riddles'
    #local dir_source=$PWD/1/testing/python2/koans
    #local dir='~/magnify_the_small/1/others/CODE/abs-guide-6.5'

    #local res1=0 
    #local full_path=''
    #local filename=''
    local cmd=''
    while :;do
        reload_cfg
        random_path


        #notify_send1 "res" "$file"
        if [ "$full_path" != '/' ];then
            #update_commander
           
            cmd1="copy $full_path"
            optional "$cmd1" "copy riddle.sh ?" question
 cmd="gedit $full_path"
            detach "$cmd"  
            #commander "$cmd"
        fi
        trace 'sleep..'        
        sleep1 $delay1
    done
    echo 'do_abs'
}
unlocker
