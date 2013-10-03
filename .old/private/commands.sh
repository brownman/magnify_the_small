grep buttons . -r

show_item() {
    show_arr 'show item()' 
    local item=${arr[$1]}
    #trace "show item: index $1: value: $item"
    echo "$item"
}



pick_one1(){                          
    trace "pick_one() got: 1:$1 2:$2"
    local str="$1"
    string_to_arr "$str"


    show_arr1 'done?' 
   
    gxmessage $GXMESSAGET -title "title" -buttons "$arr" "$str" $ICONIC 

    local num="$?"
    trace "$num"

    #local  res=$()
    if [ "$res" = 'exit' ];then
        $tasks_sh motivation glossary
    else
        notify-send "$res"
        echo0 "$res"
        #$tasks_sh scrap "$res"

    fi

    echo "$res"

}

show_arr(){
echo ''
}


show_arr1(){
    #local caller1=$(caller 0)
    local str=`echo ${arr[@]}`
    trace "show_arr:: $1:  --> $str"
}
