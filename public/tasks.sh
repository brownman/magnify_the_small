#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 


#export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE


echo  "tasks.sh got: "  >&2
echo "1: $1"  >&2
echo " 2:$2 3:$3 4: $4"  >&2


notes(){
$PLUGINS_DIR/free_speak.sh
}

present(){
   local  msg=$(grab_root "$1")
   gxmessage $GXMESSAGET "$msg"
}

grab(){
    local msg=$(parse_from "$1")
    gxmessage "$msg" $GXMESSAGET
}


recent(){
    #trace "recent: $1"
    local subject="$1"

    local str='edit mini action' 

    #local title="$subject: recent task:"

    local title=$(parse_time $subject)
    local msg=$(parse_msg $subject)
    echo0 "$msg" 

    local cmd=$(string_to_buttons "$str" "$title" "$msg" )
    if [ "$cmd" != '' ];then

        trace "num: $?"
        echo "cmd: $cmd"

        #local answer=$?

        #debug "$answer"


        eval "do_$cmd" "$subject"

    fi

}




edit(){
    local name="$1"
    local result=0
    local file1=$TODAY_DIR/txt/$name.txt
    local file2=$TODAY_DIR/yaml/$name.yaml

    gedit $file1 & 
    gedit $file2 &
}

motivation(){
    file_name="$1"
    local file=$CFG_DIR/txt/$file_name.txt

    echo "file: $file"
    xterm1 $PLUGINS_DIR/translation.sh line $file 
    
    show_file $file
    sleep 10
}
scrap(){
    local word=$( random_line $CFG_DIR/txt/glossary.txt )
    echo "word: $word"
    if  [ "$word" != '' ] ;then


        xterm1  "$PLUGINS_DIR/scrap.sh" "translate ar '$word'"
        sleep1 10

        xterm1  "$PLUGINS_DIR/scrap.sh" "translate ru '$word'" 
    fi

}

koan(){
    yellow 'add 1 koan !'
    ( bash -c $KOANS_DIR/meditate.sh &)
}


record_for_later(){
    xdg-open 'http://www.youtube.com/upload'
}
time_frame(){
    local file=public/cfg/blank.yaml 
    local file_frame=/tmp/frame.txt

    local title='time frame'
    local msg=''

    echo "" > $file_frame
    #msg=`cat $file | shyaml keys-0 frame | xargs -0 -n 1 echo "VALUE:"`
    cat $file | shyaml get-values-0 frame | \
        while read -r -d $'\0' key value; do
            msg="$key: $value"
            echo "$msg" >> $file_frame
        done
        gxmessage -file "$file_frame" $GXMESSAGET

    }



    chooser(){
        file_frame=/tmp/frame.txt

        local name="$1"
        local value=$( eval echo \$$name )
        #echo "name: $name"
        #echo "value: $value"

        local str="$value"


        local title='time frame'
#parse_one doing 
#parse_one timing 
echo -n '' > $file_frame
#local array=( doing timing should notebook breath )



#parse_one breath
local msg=$(parse_from frame.should)


#parse_one timing
#parse_one doing
#parse_one sport 


echo0 "$msg"


        #local msg=`cat $file_frame`

        res=$( string_to_buttons "$str" "$title" "$msg" )


        eval "do_$res"
        echo "$res"
    }
    tasker(){
        pick='routes.we.tasks.easiest'


    }
    take_photo(){
        $PLUGINS_DIR/take_photo.sh
    }
    show_file(){

        local    file="$1"

        string_to_buttons_file 'cancel edit' '2 options' $file
        answer=$?

        if [[ $answer -eq 1 ]];then
            gedit $file

        else
            echo 'skip editing'
        fi

    }


    show(){
        echo "show() got: $1 $2"
        local name="$1"

        flite "minimizinged file" # - $name"
        local file=$CFG_DIR/txt/$name.txt
        touch $file
        show_file "$file"

    }

    time1(){
        date1="$(date +%H:%M)"
        ( gxmessage  -buttons "_$last_task" "time: $date1"  -sticky -ontop -font "serif bold 74" -timeout $TIMEOUT1 &)
        echo4 "$date1"
    }

    update(){
        cyan "update:"
        title="NOW DOING:"
        file=$now_txt
        add_line $file "$title" true #add time note 
        tile="EFFICIENT COMMITMENT:"
        file=$ideas_txt
        add_line $file "$title"
    }



    wish(){
        echo -n 'to be implemented: '
        blue "$1"
    }

    act(){
        yellow "act() got: 1: $1 | 2: $2 | 3: $3"
        #eval '$1 "$2" "$3"'
        #eacher "$1"
    }

    suspend1(){

        local msg=`cat public/cfg/blank.yaml | shyaml get-value frame.should`
        #flite "should - $msg"
        flite 'update your notebook'

        motivation sport
        $PLUGINS_DIR/suspend.sh







    }

    is_valid1(){
        file="$1"
        is_valid "$file"
        yellow "$?"
    }


    report(){
        echo 'update google blogger with the score for this cycle'
    }

    collaboration(){
        #(      \'xterm1 $PLUGINS_DIR/collaboration.sh &)
        $PLUGINS_DIR/collaboration.sh 
        #sleep1 30
    }

    commitment(){
              xterm1 $PLUGINS_DIR/stop_watch.sh 
        #$PLUGINS_DIR/stop_watch.sh 
    }

    game_essay(){
        $PLUGINS_DIR/game_essay.sh
    }

    learn_langs(){
        if [ "$DEBUG" = 'true' ];then

            $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM 
        else

            ( xterm1 $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM &)
        fi

        #RU 13
    }



    eval "$1" '"$2" "$3"'

