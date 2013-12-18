notify-send1  'plugin:' 'must' 
run1(){


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
run(){
local file=$DATA_DIR/tmp/must.tmp
   while read -r line
    do
        [[ $line = \#* ]] && continue
        if [ "$line" != ''  ];then
            arr+=("$line")
        fi
    done < $file
local str=$(check_boxes)
#echo "$str"


        #update_commander
    IFS='|' read -a lines <<< "$str"
       for line in "${lines[@]}"
    do

commander "$line"
    done

echo "$str"
}



run
