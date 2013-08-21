# about file:
# description: update blogger with yesturday file
#- efficiency_push:
#        - easy show statistics
#        - where_am_i ?
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/user.cfg
. $TIMERTXT_CFG_FILE


file=$CFG_DIR/yaml/blank.yaml

$PLUGINS_DIR/blogger.sh $file
