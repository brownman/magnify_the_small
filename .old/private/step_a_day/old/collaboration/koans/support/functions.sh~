# http://stackoverflow.com/questions/7650438/bash-funcname-value-expanding
# Required for the alias trick to work
shopt -s expand_aliases
notify-send 'function.sh'
say3() {
    local msg="$1"
    echo "say3() got :    $1 "
    (echo "$msg" | flite -voice rms &)

    #echo "$msg" | flite -voice slt
}

green() {
    echo -e "\033[32m$1\033[0m"
}

red() {
    echo -e "\033[31m$1\033[1m"
}
yellow() {
    echo -e "\033[33m$1\033[0m"
}
blue() {
    echo -e "\033[34m$1\033[0m"
}






assertEqual2() {
    echo 'zz'
}

assertMatch1() {
    echo "assert match: check if blue contains yellow word "
    blue "BLUE:"
    if [ "$3" = ''  ]
    then
        yellow 'first parameter is empty'
        exit 1
    fi
   blue "$3" 
   yellow "CONTAINS THIS YELLOW:"
   yellow "$4"

echo '--- MATCHES: '
  echo "$3" | grep  "$4"
echo '---'
    local res=`echo "$3" | grep -o "$4"`
    #echo  "matching: blue contains yellow?" #$res  - and - $4 ?"
    assertEqual1 "$1" "$2" "$res" "$4" "$5"
#return $?
exit 1
    
    
}
assertEqual1() {

        local filename=`grep  $1 src/* -l`
        local str=''
    if [ "$3" != "$4" ]; then
        echo ''

        local str0=$( echo "$1" | sed 's/_/ /g' )
        local str1="$str0" # - has damaged your karma"
        red "$str1"
        echo "You have not yet reached enlightenment ..."

        red  "  Expected $3, got $4"


        notify-send "$str1 -        $3    =?    $4"



        local len2=`expr length "$3"`
        local len1=`expr length "$4"`
        ###

        if [ "$len1" -gt "10" ]; then
            echo "" #Can't translate more than 100 characters at once! entered $len1"
            #exit 2
        fi
   

        ###
        if [[ $SILENCE = 'false' ]]; then
           # echo "$str1" | festival --tts
           ( say3 "$str1" true &)
           # say1 "  Expected  '$3', and  expected '$4' , to be equal" false 
            #| festival --tts
        fi

        echo ''
        echo "Please meditate on the following code:"



         str="  $filename:$2"
        
        red "$str"  
    notify-send "$str"
        echo ''
        # echo "You are now 10/291 koans and 2/36 lessons away from reaching enlightenment"
        exit 1
    else
        if [ "$5" != '' ]
        then
            notify-send "$5"
     str="  $filename:$2"
        
        green "$str"  
    notify-send "$str: $5"
    say3 "$5" &

        exit 1
        fi

 
   
    fi
}
# This allows us to get the name of the functionw where this function was called
# http://stackoverflow.com/questions/7650438/bash-funcname-value-expanding

alias assertEqual='assertEqual1 ${FUNCNAME} ${LINENO}'

alias assertMatch='assertMatch1 ${FUNCNAME} ${LINENO}'
