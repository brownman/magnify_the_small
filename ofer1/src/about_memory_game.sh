green "Conditions"


declare -i counter1 
declare -i score1 

check_in_file(){


local group1="$1"
local file=$2
#local item=$1

#local result=$(cat /tmp/test1 | grep -o "$item" | wc -l)
local group2=$( cat "$file" )
check_subgroup "$group1" "$group2"

return $?

}
check_subgroup() {
    local number=0
    local group1="$1" #"root boots"
    local group2="$2" #"root boot boots"
    local answer=0 


    for item in $(echo $group1)
    do 
        #notify-send "item is: $item"
check_item "$item" "$group2" 
        answer=$?
           # let "answer += 0"

        #notify-send "answer is :  $answer"

        if [ $answer = 1 ]
        then
            let "number += 1"
        else

            let "number -= 0"
           

        fi



    done

    return $number

}

max2 ()             # Returns larger of two numbers.
{                   # Note: numbers compared must be less than 250.

    if [ -z "$2" ]
    then
        return $E_PARAM_ERR
    fi

    if [ "$1" -eq "$2" ]
    then
        return $EQUAL
    else
        if [ "$1" -gt "$2" ]
        then
            return $1
        else
            return $2
        fi
    fi
}

#max2 33 34
#return_val=$?



#myfunc result
#echo $result
#result2=$(myfunc)
#echo $result2
check_item(){
    #notify-send " $1 -exist- in $2 ?"
    local result

    #group=[ 'boot' , 'root' , 'boots' ]

    item=$1 #'root'
    group=$2 #"boots roots root"

    #count instances of item in group

    local count=$(echo "$group" | grep -o "$item"   | wc -w )

    #notify-send "score is $count" 

    result=$( test $count -eq 0  && echo 0 || echo 1 )
    #tmp=$result
    #notify-send "result is: $result"
    return $result

}
check_score(){
    score2=$1
    #score+=1
    score2+=1
    #score1=$1
    #score1+=1




}

test_game() {

    local test='ok'

    if [ $test = 'ok' ]; then
        local assert='YES'
    fi

    assertEqual $assert 'YES'

}


test_compare_syntax() {

    #http://www.ibm.com/developerworks/library/l-bash-test/index.html

    #test and [
    #test expr and [ expr ] are equivalent.
    #You can examine the return value by displaying $?;
    #local str="a b c"
    local result=$( test 3 -gt 4 && echo True || echo false )
    assertEqual $result false 

    [ "abc" = "def" ]; #asign result to: $
    result=$(echo $?)

    #0 is true
    assertEqual $result 1 #1 or 0 ? 

    [ "abc" \< "def" ];
    result=$(echo $?)

    assertEqual $result 0 #1 or 0 ? 

}
test_regex(){

    #Operator	Effect
    #.	Matches any single character.
    #?	The preceding item is optional and will be matched, at most, once.
    #*	The preceding item will be matched zero or more times.
    #+	The preceding item will be matched one or more times.
    #{N}	The preceding item is matched exactly N times.
    #{N,}	The preceding item is matched N or more times.
    #{N,M}	The preceding item is matched at least N times, but not more than M times.
    #-	represents the range if it's not first or last in a list or the ending point of a range in a list.
    #^	Matches the empty string at the beginning of a line; also represents the characters not in the range of a list.
    #$	Matches the empty string at the end of a line.
    #\b	Matches the empty string at the edge of a word.
    #\B	Matches the empty string provided it's not at the edge of a word.
    #\<	Match the empty string at the beginning of word.
    #\>	Match the empty string at the end of word.
    #http://tldp.org/LDP/Bash-Beginners-Guide/html/chap_04.html
    result2=$(grep '\<qu*n\>' /usr/share/dict/words)

    groupr0=$(grep '\<.o\{2\}t\>' /usr/share/dict/words)
    group='boot boots root'
    item="boot"
    #result=(grep $item $group1)


    result=$(echo "$group" | grep -o "$item"   | wc -w )


    assertEqual "$result" 2 #1 or 0 ? 

    result=$( test $result -eq 0 && echo True || echo false )
    #echo "result1"
    #result=$(echo "$result1" ) #| wc -w )


    assertEqual "$result" false #"game on" 
    #res=$( assertEqual "$result" false )
    #res=$(assertEqual "$result" 0 )
    #assertEqual $res 5

}
test_item_in_group() {
    local tmp1

    item="boot" 
    group="root boot boots" 
    check_item "$item" "$group" 

    local res=$?
    
    assertEqual $res 1   
}
test_group_in_group(){
    #http://tldp.org/LDP/abs/html/complexfunct.html#REFPARAMS
    #max2 7 4
    group1="boot boots" 
    group2="root boot boots" 
    check_subgroup "$group1" "$group2" 
    assertEqual $? 2 
}
test_in_file(){
    #http://tldp.org/LDP/abs/html/complexfunct.html#REFPARAMS
    #max2 7 4
    local group1="boot boots" #boot1 boot boots" 
    local group2="root boot boots" 
    local file=/tmp/test1
    #check_subroup "$group1" "$group2" 
    echo "$group2" > /tmp/test1
    check_in_file "$group1" /tmp/test1

    assertEqual $? 2 
}





