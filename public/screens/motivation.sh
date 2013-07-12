#!/bin/bash

# about file:
# have profit !
# increase my motivation by printing one line from the collection and translate it
#  
#
#
. $TIMERTXT_CFG_FILE

escort(){
echo "choose a language:"
read answer
if [ "$answer" != '' ];then
    update_lang "$answer"
else
    echo "stick to default language: $LANG"
    update_lang "ru"
fi

    old_IFS=$IFS
    IFS=$'\n'
    lines=($(cat $philo_txt)) # array
    IFS=$old_IFS
    for var in "${lines[@]}"
    do
        str="${var}"
        #echo "$str"
        echo4 "$str"
        read answer
        if [ "$answer" = 'exit'  ];then
            exiting
        else
            echo "$answer" >> "$mini_tasks_txt"
            echo4 "$answer"
        fi

    done
}

escort
exiting
sleep1 3
max=`cat -b $motivations_txt | wc -l`
random1 $max
num=$?
let "num += 2"
echo "num is $num "
str=`cat $motivations_txt | head -$num | tail -1`
echo4 "$str" 

max=`cat -b $quotes_txt | wc -l`
random1 $max
num=$?
str=`cat $quotes_txt | head -$num | tail -1`
echo4 "$str" 


