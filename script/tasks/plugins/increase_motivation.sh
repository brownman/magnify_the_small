

loop(){

    local delay=60

    delay=$(gxmessage -entrytext "$delay" -title 'enter new' 'delay' $GXMESSAGET)
    local answer="because"

    while :;do

        local  trigger=$(random_reason)
        helper0 "$trigger" $file_log  
        local answer=$(gxmessage -entrytext ""  -title 'new reason:' "$trigger" $GXMESSAGET )

        #sub-funcs can run break command
        eval 'helper0 "$answer" "$file_log"'

        local  cmd="sleep2 '$answer' '$trigger' '$delay'" 
        res=$(commander "$cmd")
        #silently_run "$cmd"
    done

}

run(){
    loop
}

run
