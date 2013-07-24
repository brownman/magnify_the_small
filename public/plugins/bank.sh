#!/bin/bash
# about file:
# fast update for txt files


export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

echo 'help: use:'
blue 'txt_file |  title | content '
blue 'txt_file |  url | content'
file="$1"
title="$2"
content="$3"
filename="${file}.txt"
#touch $DYNAMIC_DIR/${filename}
#echo "$DYNAMIC_DIR/$filename|$title|$content"

echo "$title|$content" >> $DYNAMIC_DIR/${filename}
cat $DYNAMIC_DIR/${filename}


