notify-send1  'plugin:' 'must' 

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
tasker update_points "$str"
#echo "$str"


        #update_commander
    IFS='|' read -a lines <<< "$str"
       for line in "${lines[@]}"
    do

detach "$line"
    done

echo "$str"
}



run
