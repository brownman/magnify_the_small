commitment1(){

    str6=$( date | awk -F ' ' '{print $4}' )
    echo -n "dear:  "
    green "$NAME1"
    echo -n "the time is: "
    red "$str6"
    echo -n  "you commited to the next obligation:  "
    str=`cat  $commitment_txt | head -1`
    white "$str"


    #$timer_sh  translate  "$str" "it"  
    #$timer_sh  translate  "$str" "ru"  
    #$timer_sh  translate  "$str" "tl"  
    #$timer_sh  translate  "$str" "ar"  
    #$timer_sh  translate  "$str" "ru"  
    #( echo "$str" | flite &)

    #"until X i finish doing Y and start doing Z"
    cyan 'update commitment ?'
    ( echo4 "$str" &)
    read answer
    if [ "$answer" = 'y' ];then


        cyan 'until:'
        read x
        cyan 'I finish doing:'
        read y
        cyan 'and start doing:'
        read z

        if  [ "$x" != '' ]     && [ "$y" != '' ]    && [ "$z" != '' ] 
        then
            echo "until $x - I finish  $y - and start  $z" > $commitment_txt
            exiting
        else
            echo 'error on input'
            exiting
        fi
    elif [ "$answer" = 'n' ];then

        red "Must log in to continue ?"

        read        answer
        if [  $answer = y ];then

            green "$NAME1 is commited ! "
        else

            $timer_sh suspend
        fi
    else
        exiting

    fi


}




