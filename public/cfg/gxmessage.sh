#!/bin/bash
# about file:
# fix comptability: gui or non gui 
# 

. $TIMERTXT_CFG_FILE

echo -n   "gxmessage():"
yellow "$@"


#answer=$( gxmessage  -title "$title" -file  "$file" -ontop -timeout 10 -entry )
program=/usr/local/bin/gxmessage

file="$1"
title="$2"

timeout=10
entry=true
ontop=true
exec $program -title "$title" -file "$file" -timeout "$timeout" -entry -ontop




