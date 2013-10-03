#!/bin/bash
# about file:
# run 1 test
#   
# 

#. $TIMERTXT_CFG_FILE


#blue  "kaon.sh got: "
#echo2 "1: $1"
#echo2 " 2:$2 3:$3 4: $4"


function step1 {
local result="$1"
#echo 'step1()'

let 'result += 2'
echo $result
}




step1 1
