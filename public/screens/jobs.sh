#!/bin/bash

# about file:
# have profit !
# increase my motivation by printing one line from the collection and translate it
#  
#
#
. $TIMERTXT_CFG_FILE
file=$STORY_DIR/${1}.txt



delete_file(){

    cat $blank_txt
    red "clean file ? $blank_txt" 


    read answer
    if [ "$answer" = 'y' ]
    then
        red 'cleaning..'
        echo '' > $blank_txt
    else
        green 'skipping'
    fi
}



imaginary_friend(){

    echo "choose a language:"
    read answer
    if [ "$answer" != '' ];then
        update_lang "$answer"
    else
        echo "stick to default language: $LANG"
        update_lang "ru"
    fi

    echo "\n $date" >> "$mini_tasks_txt"
    old_IFS=$IFS
    IFS=$'\n'
    lines=($(cat $file)) # array
    IFS=$old_IFS
    for var in "${lines[@]}"
    do
        str="${var}"
        #echo "$str"
    xdg-open $str 
    done
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

cyan "create a story:"
delete_file
imaginary_friend
publish1 
