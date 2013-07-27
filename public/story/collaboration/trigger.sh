#!/bin/bash
#current project
ls -1 **/*.sh
echo 'enter question:'
read answer
if [ "$answer" != '' ];then
  echo "$answer" >> questions.txt 
fi
echo 'choose script: '
read answer
if [ "$answer" != '' ];then
  exec $PWD/$answer
fi

