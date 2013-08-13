#!/bin/bash
# about file:
# plugin:        take_photo.sh 
# description:   take a picture   
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
dir1=~/pictures/


snap(){
    #echo4 "$last_camera_before" 
    pic_file=$(echo $dir1/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)
    ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file
    #echo4 "$last_camera_after" 
    (xloadimage $pic_file &)
    #(xloadimage $uml_pic &)
}

snap
