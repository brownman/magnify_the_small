koan(){
    local input=''
    local entry1='step1 1'
    while :;do
        input=$( gxmessage -entrytext "$entry1" -title "test 1 koan" "$input" $GXMESSAGE1 )
        if [ "$input" != '' ];then
            result=$( $PUBLIC_DIR/koan.sh $input )
            #result=$?
            gxmessage -title "result: " "$result" $GXMESSAGE1
        else
            break
        fi
    done
}


glossary_aday(){
        cyan 'have profit !'
        yellow 'imagine an ideal day !'
        cat $glossary_txt
        file_guide=$MORNING_DIR/glossary.txt
        #http://en.wiktionary.org/wiki/Wiktionary:Frequency_lists
        cat $file_guide
        read 
        $SCREENS_DIR/motivation.sh $file_guide
}






uml_me(){
#echo 'http://bash.cyberciti.biz/guide/Source_command'
#echo http://www.offensive-security.com/metasploit-unleashed/Getting_A_Shell
#xdg-open http://www.plantuml.com/plantuml/ &
#blue 
#xdg-open 'http://plantuml.sourceforge.net/activity2.html#simple' &
#blue 'http://alternativeto.net/?platform=linux'
yellow 'save the world for those who left behind !'
sleep1 2
eacher glossary_aday "glossary of the day ?"
eacher breakout_idea_prison "breakout idea prison ?"
eacher new_day "uml a day ?"
}
new_day(){

    msg1=`log4`
    #msg1="print me!"
    $PUBLIC_DIR/menus.sh "$msg1"
}



ideas_bank_for_later(){
    green 'edit ideas ?' 
    read answer
    if [ "$answer" = 'y'  ];then
        gedit $ideas_txt &
        gedit $STORY_DIR/words_of_peace.txt &
    fi
    green 'upgrade productivity ?' 
    read answer
    if [ "$answer" = 'y'  ];then
        gedit $readme_md &

    fi

    relax

}

breakout_idea_prison(){

    eacher ideas_bank_for_later 'need to break free ?'
    #asave idea for later and connect earth ?'
}


