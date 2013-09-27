#!/bin/bash
# about file:
# string to buttons -> choose -> echo -> say

#http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
trace "string_to_buttons.sh got:  method:$1 arg:$2 3:$3" 
#delimeter='-'
#delimeter=''

empty='Q'
arr=()
declare -a arr=() #=('aa')

arr_to_msg(){
gxmessage -buttons "$1" -file $file_memory $GXMESSAGET -iconic
local num=$?
local str="${arr[$num]}"
trace "$str"
echo "$str"
}

make_assosiation(){
    local str="$1"
    local ass=$(gxmessage -entrytext "$str|$LANG_DEFAULT|" -title "sound like:"  -file $file_assosiation $GXMESSAGET )
    if [ "$ass" != '' ];then

    echo "$ass" >> $file_assosiation
    fi
  
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

local str="Q - $1"
delimeter="${2:-' '}"   # Defaults to /tmp dir.
str_to_arr "$str" #create new array
local str2=$(arr_to_str ) #use array to create buttons-string
#echo "$str2"trace "$str2"
#trace "arr: ${arr[@]}"
local str3=$(arr_to_msg "$str2")

local str4=$(remove_trailing "$str3")
trace "=$str4="
if [ "$str4" = "$empty" ] || [ "$str4" = "-" ] 
then
    trace "choosen: empty string: -$str4-"
else
update_file $file_memory "$str4"
    echo01 "$str4"
    make_assosiation "$str4"
fi

echo "$str4"


}

step2 "$1" "$2"


