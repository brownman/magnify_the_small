#!/bin/bash
# about file:
# plugin:       parse yaml file

#. $TIMERTXT_CFG_FILE

file1=$CFG_DIR/blank.yaml
tracex "yaml_parser got: 1:$1 2:$2"
parse_from(){
    parse_from ""
    local location="$1"


    local msg=`cat $file1 | shyaml get-value $location`
    tracex "msg: $msg"


    local msg1=`cat $file1 | shyaml $msg`
    trace "msg1: $msg1"
    #gxmessage $GXMESSAGET $msg1
    echo "$msg1"

}

parse_one(){

    local file1=public/cfg/blank.yaml
    local subject="$1"
    local msg=`cat $file1 | shyaml get-value frame.$subject`

    local file2=/tmp/frame.txt
    echo "$subject:    $msg" >> $file2

}



grab_it(){
    local subject="$1"
    local file="$CFG_DIR/blank.yaml"
    local msg1=`cat $file | shyaml get-value frame.$subject`
    echo "$msg1"
}
grab_root(){
    local subject="$1"
    local file="$CFG_DIR/blank.yaml"
    local msg1=`cat $file | shyaml get-values $subject`
    echo "$msg1"
}


parse_msg(){
    trace "parse $1 $2"
    local route="$1"
    local msg=`cat $file_data | shyaml get-values routes.$route.recent`
    echo "$msg"
}
parse_time(){
    trace "parse $1 $2"
    local route="$1"
    local msg=`cat $file_data | shyaml get-values routes.$route.timing`
    echo "commitment in time: $msg"
}
present_yaml(){
    echo ''
}

present_recent_steps(){

    echo ''
}

recursive_menu(){

    echo ''
}

chooser1(){
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

recent_step(){
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

present(){
    local  msg=$(grab_root "$1")
    gxmessage $GXMESSAGET "$msg"
}

fetch(){
    local msg=$(parse_from "$1")
    local title="$1"
    trace $msg
#$tasks_sh commitment "$msg"

    #echo0 "$msg"

    #gxmessage "$msg" -title "$title" $GXMESSAGET
     #"$msg" "$title" 
     echo "$msg"

}

generate_workflow2(){
local    file=$CFG_DIR/workflow1.cfg

echo $(grab_root 'workflow') > $file

cat $file
cat $file
}

generate_file(){

    trace "generate_file() got: 1:$1 2:$2"

    local subject="$1" #'workflow' #"$2" #'workflow'
    local new_file="$2" #/tmp/new.txt #"$1"


    local title='time frame'
    local msg=''
    local msg1=''

    msg1=`cat $file_data |  shyaml get-values $subject`
    # | xargs -0 -n 1 echo "VALUE:"`
    echo "$msg1" > $new_file
    cat $new_file
    #>> 
        #gxmessage $msg1 $GXMESSAGET
exiting
    local file_frame=/tmp/frame.txt
    echo "" > $file_frame

    cat $file | shyaml get-values-0 frame | \
        while read -r -d $'\0' key value; do
            msg="$key: $value"
            echo "$msg" >> $file_frame
        done
        gxmessage -file "$file_frame" $GXMESSAGET




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


    tasker(){
        pick='routes.we.tasks.easiest'


    }   
    yaml_menu(){
        echo 'present step: we.recent we.action we.mini-steps' 
    }

    is_valid1(){
        file="$1"
        is_valid "$file"
        yellow "$?"
    }


    eval "$1" '"$2" "$3"'
