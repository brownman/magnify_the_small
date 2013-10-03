#!/bin/bash


gxmessage -buttons 'test:0,use:1' 'decide:' -timeout 10
answer=$?
if [ $answer -eq 0 ];then
./testing/python2/run.sh
else
./prespective/timer.sh "$1"
fi

