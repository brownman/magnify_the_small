# about file:
# description: update blogger with yesturday file
#- efficiency_push:
#        - easy show statistics
#        - where_am_i ?
pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=$PWD/public/cfg/user.cfg
. $TIMERTXT_CFG_FILE



file=$CFG_DIR/blank.yaml


upload(){
$PLUGINS_DIR/blogger.sh $file
}

backup(){
    trace 'backup'
old_file=$(echo $CFG_DIR/old/blank-$(date +%m_%d_%Y_%H_%M).yaml)
mv $file $old_file
echo $date1
ls -l $old_file
touch $file
}

eacher upload 'upload file to blogger?'
eacher backup 'clean blank.yaml ?'

popd > /dev/null
