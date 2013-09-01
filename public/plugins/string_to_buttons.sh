#!/bin/bash
# about file:
# string to buttons -> choose -> echo -> say


trace "string_to_buttons.sh got:  method:$1 arg:$2 3:$3" 




show_item(){
    trace "show_item() got:  1:$1 2:$2" 
    local str="$1" 
    local index="$2"
    delimeter=' '
    old_IFS=$IFS
    IFS="$delimeter"
    read -a array <<< "$str"
    IFS=$old_IFS
    read -a array <<< "$str"
    local item=${array[$index]}
    echo "$item"
}


msg_with_buttons(){
    str="$1"
    local str_buttons=$(string_to_arr "$str")

    gxmessage $GXMESSAGET -title "title" -buttons "$str_buttons" "$str" 

    local num=$?
    local str2=$(show_item "$str" "$num" )

    trace "$str2"
    echo "$str2"

}

pick_one(){
    tracex "pick_one() got: 1:$1 2:$2"
    local  res=$(msg_with_buttons "$1")
    notify-send "$res"
    echo0 "$res"
    echo "$res"
}
string_to_arr(){
    trace "string_to_arr() got:  1:$1 2:$2" 
    str="$1" 
    delimeter=' '
    old_IFS=$IFS
    IFS="$delimeter"
    read -a array <<< "$str"
    IFS=$old_IFS

    for i in "${!array[@]}"; do
        if [ "$str1" = '' ];then
            str1="${array[$i]}:$i"
        else
            str1="$str1,${array[$i]}:$i"
        fi
    done



    #gxmessage $GXMESSAGET -title "title" -buttons "$str1"  msg 
    trace "$str1"
    echo "$str1"
    #return "$str1"

}
string_to_buttons_file1(){

    tracex "string_to_buttons()  got: 1:$1 2: $2 3:$3 4:$4"
    local str="$1"
    local title="$2"
    local file_msg="$3" 
    local delimeter="$4"

    local str1=''
    if [ "$delimeter" = '' ];then
        trace 'no delimeter found'
        delimeter=' '  
    fi

    #delimeter=${1:-60}   # Defaults to /tmp dir.

    old_IFS=$IFS
    IFS="$delimeter"
    #echo  "ifs: $IFS" >&2
    #cat $file


    read -a array <<< "$str"
    for i in "${!array[@]}"; do
        if [ "$str1" = '' ];then
            str1="${array[$i]}:$i"
        else
            str1="$str1,${array[$i]}:$i"
        fi
    done

    IFS=$old_IFS

    gxmessage $(echo $GXMESSAGET) -title "$title" -buttons "$str1"  -file $file_msg $ICONIC
    choose="$?"

    local str2="${array[$choose]}"
    echo "$str2"

    return $choose
}



string_to_buttons2(){
    tracex "string_to_buttons()  got: 1:$1 2:$2 3:$3 4:$4"
    local str="$1"
    local title="$2"
    local msg="$3" 
    local delimeter="$4"
    local result=0

    local str1=''
    if [ "$delimeter" = '' ];then
        delimeter=' '  
        trace 'no delimeter found'
    fi

    #delimeter=${1:-60}   # Defaults to /tmp dir.

    old_IFS=$IFS
    IFS="$delimeter"
    #echo  "ifs: $IFS" >&2
    #cat $file


    read -a array <<< "$str"
    for i in "${!array[@]}"; do
        if [ "$str1" = '' ];then
            str1="${array[$i]}:$i"
        else
            str1="$str1,${array[$i]}:$i"
        fi
    done

    IFS=$old_IFS
    gxmessage $GXMESSAGET -title "$title" -buttons  "$str1" "$msg"
    result=$?
    #trace "$result"
    #
    #    local str2="${array[$choose]}"
    #    trace "str2: $str2"
    #
    #    trace "choose: $choose"
    #    echo "$str2"
    #
    return $result
}



$1 "$2" "$3"
