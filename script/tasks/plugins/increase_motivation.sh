
#notify-send1 "reminder: increase motivation" "$@"

delay=5
file_locker=/tmp/increase_motivation

loop(){

    local delay=181

if [ "$delay" ];then
    

    while :;do
        local  trigger=$( random_from_subject1 trigger)
        helper0 "$trigger" $file_log  
        local answer=$(gxmessage -entrytext ""  -title 'new reason:' "$trigger" $GXMESSAGET )

        helper0 "$answer" "$file_log"

        local  cmd="sleep2 '$answer' '$trigger' '$delay'" 
        res=$(commander "$cmd")
    done

fi

}

run(){
    loop
}

unlocker
