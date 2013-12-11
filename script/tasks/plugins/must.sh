notify-send1  'plugin:' 'must' 
run(){


    #$( tasker  efficiency_report )
    #local ans=2 
    #$?
    #if [ $ans -ge 0 ];then
    tasker learn_langs &
    #if [ $ans -ge 1 ];then
    tasker git_commit &
    tasker riddle &
    #if [ $ans -ge 2 ];then
    tasker increase_motivation &
    #tasker reminder &
    #fi
    #fi
    #fi

}



run
