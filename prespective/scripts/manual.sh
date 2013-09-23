# about file:
# description: update blogger with yesturday file
#- efficiency_push:
#        - easy show statistics
#        - where_am_i ?
pushd `dirname $0` > /dev/null
cd ../public
export TIMERTXT_CFG_FILE=$PWD/cfg/user.cfg

. $TIMERTXT_CFG_FILE



file1=$CFG_DIR/blank.yaml
file2=$CFG_DIR/txt/assosiation.txt


upload(){
    local file="$1"
    local cmd=$( echo "$PLUGINS_DIR/blogger.sh $file" )
    commander "$cmd"
}

#backup(){
#    trace 'backup'
#old_file=$(echo $CFG_DIR/old/blank-$(date +%m_%d_%Y_%H_%M).yaml)
#mv $file $old_file
#echo $date1
#ls -l $old_file
#touch $file
#}

#eacher upload 'upload file to blogger?'
#eacher backup 'clean blank.yaml ?'

essay(){
  local file_name="$1"
    local cmd=$( echo "$PLUGINS_DIR/free_speak.sh $file_name" )
    commander "$cmd"
}

do_upload(){
echo 'hi'
upload $file1
upload $file2
}

do_essay(){
    local name_ws=$(    string_ws "$1" )
essay "$name_ws"
}
$1 "$2"
popd > /dev/null
