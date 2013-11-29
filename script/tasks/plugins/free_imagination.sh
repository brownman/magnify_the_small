
notify-send1 "free-imagination" "$0"

#${1:-'essay_generator|story_a_day|funny'}

delay=5
file_locker=/tmp/free_imagination
file=${1:-$DATA_DIR/txt/free.txt}


run(){
zenity_editable "$file"
}
unlocker
#run

