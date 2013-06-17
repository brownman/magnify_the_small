echo 'mail.sh: make me effective!'
missions_txt=/tmp/missions.txt
schedule_txt=/tmp/gcalcli_agenda_full.txt
#$TIMER_DIR
#/missions.txt
#ls -l  $missions_txt
#thanks_txt=$DAILY_DIR/thanks.txt
#essay_txt=$ESSAYS_DIR/essay.txt

background=/tmp/result.png

pic_file=$(echo ~/pictures/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)
ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file && Xloadimage $pic_file

txt_file=$(echo ~/pictures/done-$(date +%m_%d_%Y_%H_%M).txt)

xloadimage $pic_file

str=$( gxmessage -entry -title 'press no for cancel the sending to Kuka' -file  $mission_txt -timeout 10 )


if [[ $str != 'no'  ]]
then

    echo 'sleep 10 seconds !'
    sleep 10s

 convert /tmp/result.png -resize 800x600 /tmp/result.png


    mpack -s 'my pic' $pic_file $MAIL1
    mpack -s 'my pic' $pic_file $MAIL2 

    mpack -s 'my luz'  $schedule_txt $MAIL1
    mpack -s 'my luz'  $schedule_txt $MAIL2
    
    mpack -s 'my missions'  $missions_txt $MAIL2 
    mpack -s 'my missions'  $missions_txt $MAIL1 

else
    notify-send 'not sending !'

fi

