#!/bin/bash

# about file:
# have profit !
# increase my motivation by printing one line from the collection and translate it
#  
#
#
. $TIMERTXT_CFG_FILE
file_guide="$1"

delete1(){

    echo '' > $blank_txt
}
guide1(){


    cyan 'are you creative now ?'
    ls -1 $STORY_DIR
    read answer

    local file=$STORY_DIR/${answer}.txt

    files=$(ls  $file 2> /dev/null )

    if [[  "$files"  ]]
    then
        #$SCREENS_DIR/motivation.sh "$answer"
        file_guide=$file
        #$STORY_DIR/${1}.txt
        green "$file"
        sleep1 2
        menu1
    else
        red 'file not found'
    fi


    sleep1 2


}

new1(){
    cyan "guidance: $file_guide"
    echo "choose a language:"
    read answer
    if [ "$answer" != '' ];then
        update_lang "$answer"
    else
        echo "stick to default language: $LANG"
        update_lang "ru"
    fi

    #echo "\n $date" >> "$mini_tasks_txt"
    old_IFS=$IFS
    IFS=$'\n'
    lines=($(cat $file_guide)) # array
    IFS=$old_IFS
    for var in "${lines[@]}"
    do
        str="${var}"
        #echo "$str"
        echo4 "$str"

        if [ "$str" != 'ho' ];then
        echo -n "$str  " >> "$blank_txt"
        fi


        
        read answer
        if [ "$answer" = 'exit'  ];then
            break 
        else
            echo "$answer" >> "$blank_txt"
            echo4 "$answer"
        fi
    done
}

spell1(){

    #cat $blank_txt
    aspell -a <<< `cat $blank_txt`
    gedit $blank_txt
}

publish1(){
    cyan "story:"
    cat $blank_txt




    green 'publish to blog ?'
    read answer

    if [ "$answer" = 'y'  ];then

        echo 'enter title:'
        read title 
        echo 'enter tags comma-saperated:'
        read tags 

        echo 'continue to publishing ?'
        read answer
        if [ "$answer" = 'y'  ];then
            google blogger post --title "$title" --src "$blank_txt" --tags "$tags"
        fi
        echo "open the blog website ?"
        read answer
        if [ "$answer" = 'y'  ];then
            xdg-open $url_blog
        fi
    fi
}

menu1(){


    PS3="choosen guide:  $file_guide:  " 
    options=(  "Quit" "Delete" "Spell" "Publish" "Guide" "New" )
    reset
    select opt in "${options[@]}"
    do

        case $opt in
            "Quit")
                exiting    
                ;;
            "Delete")
                delete1
                ;;

            "Spell")
                spell1
                ;;
            "Publish")
                publish1
                ;;
            "New")
                new1
                ;;
            "Guide")
                guide1
                ;;
            *)
                reset
                ;;
        esac
    done   




}


menu1
