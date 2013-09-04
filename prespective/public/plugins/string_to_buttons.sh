#!/bin/bash
# about file:
# string to buttons -> choose -> echo -> say

#http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
trace "string_to_buttons.sh got:  method:$1 arg:$2 3:$3" 
#delimeter='-'
#delimeter=''
file_memory=/tmp/memory.txt
empty='Q'
arr=()
declare -a arr=() #=('aa')

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
   
    gxmessage $GXMESSAGET -title "title" -buttons "$arr" "$str" 

exiting
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
arr_to_msg(){
gxmessage -buttons "$1" -file $file_memory $GXMESSAGET
local num=$?
local str="${arr[$num]}"
trace "$str"
echo "$str"
}
str_to_arr(){
    trace "string_to_arr() got:  1:$1 2:$2" 
    #  local item=${arr[1]}`
    #    gxmessage "res1: $item"
    str="$1" 

    old_IFS=$IFS
    #show_arr 1
    #read -a arr <<< "$str"
    IFS="$delimeter"

    arr=($(echo "$str"))

    IFS=$old_IFS

}
arr_to_str(){

#local str1="$1"
local item=''
local item1=''
    for i in "${!arr[@]}"; do
item=${arr[$i]}
#item1=$(remove_trailing "$item")
        if [ "$str1" = '' ];then
            str1="$item:$i"
        else
            str1="$str1,$item:$i"
        fi
    done
#
#    show_arr1 'string_to_arr() 1' 
#
#
#
#    trace "$str"
    echo "$str1"

}
step1(){
local str="$1"
delimeter="${2:-'-'}"   # Defaults to /tmp dir.
str_to_arr "$1" #create new array
local str2=$(arr_to_str ) #use array to create buttons-string
echo "$str2"
}
step2(){

local str="Q-$1"
delimeter="${2:-'-'}"   # Defaults to /tmp dir.
str_to_arr "$str" #create new array
local str2=$(arr_to_str ) #use array to create buttons-string
#echo "$str2"trace "$str2"
#trace "arr: ${arr[@]}"
local str3=$(arr_to_msg "$str2")
if [ "$str" != "$empty" ];then
update_file $file_memory "$str3"
else
    tracex "choosen: empty string: -$str3-"
fi

echo "$str3"


}

$1 "$2" "$3"


