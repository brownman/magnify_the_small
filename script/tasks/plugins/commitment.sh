}

commit1(){
    local file=$DATA_DIR/tmp/currently.tmp
    local goal=$(zenity1 $file)
    stop_watch1  "$goal" 
}

run(){

commit1
}
unlocker
