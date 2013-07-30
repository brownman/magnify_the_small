#!/bin/bash
# about file:
# plugin:      logger - update file - push 1 line on top 
# description: translate 1 line of text to many languages by choice
# gui: yes
# cli: no
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

messageANS() {

    local title="$1"
    local file="$2"
    #local result=
    result=$( gxmessage -center  -nofocus       -title "$title" -file $file -timeout 15 -entry )

    if [ "$result" != '' ];then
        cat $rules_txt > /tmp/rules
        echo "$result" > $rules_txt
        cat /tmp/rules >> $rules_txt
    fi


}
messageFYN() {

    local title="$1"
    local file="$2"
    #local result=

    result=$( gxmessage  -buttons "No":1,"Yes":2       -title "$title" -file $file $GXMESSAGET )
    echo "$?"
    return "$?"
}
messageYN() {

    local title="$1"
    local str="$2"
    local result=0

    if [ "$GUI" = 'true' ];then
        result=$( gxmessage -buttons "No":1,"Yes":2          -title "$title" "$str"  $GXMESSAGET )
    else
        green "$str"
        read result
        if [ "$result" = 'y' ];then
            result=2
            let "result = 2"
        else
            let "result = 1"
        fi
    fi
    return $result
}

add_line(){
    echo2 "add line got: file:$1 title:$2 3:$3"
    #latest modifications: 
    #pass reference by supplying name of global variable.
    local file="$1"
    local title="$2"
    local when="$3"
    local last_msg='yes, you can'
    while :;do

    answer=$( gxmessage  -title "$title" -file  "$file" -ontop -timeout 10 -entry )
    if [ "$answer" = '' ];then
        sleep1 5
        #$PLUGINS_DIR/translation.sh $last_msg
        
        
        $PLUGINS_DIR/translation.sh line $TODAY_DIR/txt/glossary.txt 
   elif [ "$answer" = 'exit' ];then
        break;
    elif [ "$answer" = 'delete1' ];then
       echo '' > $file 
    elif [ "$answer" = 'remind1' ];then
     gxmessage  -title "I have time for everything:" -file  "$TODAY_DIR/txt/times.txt" -ontop -timeout 10
    else
        if [ "$when" = 'true' ];then
            date1="$(date +%H:%M)"
            str="$date1 - $answer"
        else
            str="$answer"
        fi
        if [ "$last_msg" != "$answer"];then
        last_msg="$answer"
        update_file $file "$str"
        fi
       
    if [  "$PROFIT" = true ];then
            $PLUGINS_DIR/translation.sh sentence "$answer" 
        fi
    fi

    done

}
update_file(){
    echo "update_file got: file: $1 | msg: $2 | $3"
    local file="$1"
    local msg="$2"
  
        cat $file > /tmp/1.txt 
        echo "$msg" > $file
        cat /tmp/1.txt >> $file
}




eval "$1" '"$2" "$3" "$4"'
