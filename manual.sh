# about file:
# description: update blogger with yesturday file
#- efficiency_push:
#        - easy show statistics
#        - where_am_i ?
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/user.cfg
. $TIMERTXT_CFG_FILE


file=$CFG_DIR/blank.yaml


upload(){
$PLUGINS_DIR/blogger.sh $file
}

backup(){
old_file=$(echo $CFG_DIR/old/blank-$(date +%m_%d_%Y_%H_%M).yaml)
mv $file $old_file
echo $date1
ls -l $old_file
touch $file
}

upload
backup
