#!/bin/bash

# about file:
# - recored your steps
# - cherish suspension 
#
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 
POINTS_SUSPEND=0
POINTS_OTHER_HEART=0
POINTS_REPORT=0
POINTS_IMAGINE=0
help_options="smaller_step|network|recent"


network(){
    echo "network() got $1"
file=$TODAY_DIR/code/linux.sh

gedit $TODAY_DIR/code/linux.sh

bash -x $file "$1"


}
step(){
echo2 "add() got: $1 $2"

file_name="$1"
msg="$2"

local file1=$TODAY_DIR/${file_name}.yaml
echo "#$msg" >> $file1
local file=$TODAY_DIR/${file_name}.sh
echo "#$msg" >> $file
echo -n 'file: '
green "$file"
#echo 'edit andrelamusia ?'
#read answer
#if [ "$answer" = y ];then
#xdg-open http://yaml-online-parser.appspot.com &
#vi $TODAY_DIR/andrelamusia.yaml
#fi

echo 'edit reminders ?'
read answer
if [ "$answer" = y ];then

echo 'edit the prespective file first' 
gedit $TODAY_DIR/yaml/plan.yaml &
gedit $TODAY_DIR/yaml/me.yaml & 


fi

echo 'edit file ?'
read answer
if [ "$answer" = y ];then
gedit $file &
gedit $file1 &

fi

echo 'run file ?'
read answer
if [ "$answer" = y ];then


exec $file & 
fi



}

recent(){
echo 'recent activities:'

#jobs
    #http://www.alljobs.co.il/

#cooperation
    #https://c9.io/brownman/angular-phonecat
    #https://codenvy.com/ide

}

guidance(){

#what
#how
#how long
echo ''
}

help1 "$help_options"

#help1 $help_options
eval $1 '"$2" "$3"'

exit
#/TORRENTS/CODE1/RAILS/ANGULAR/AngularJS-Testing-Article
