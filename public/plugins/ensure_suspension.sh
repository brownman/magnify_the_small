#!/bin/bash
# about file:
# plugin:        ensure suspension!
# description:   separate the proccess running the suspend.sh
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

help_options='wait for 5m |  suspend'
help1 "$help_options"
sleep1 300 
$PLUGINS_DIR/suspend.sh
