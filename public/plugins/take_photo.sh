take_photo(){
    echo4 "$last_camera_before" 
    pic_file=$(echo ~/pictures/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)
    ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file
    echo4 "$last_camera_after" 
    (xloadimage $pic_file &)
    (xloadimage $uml_pic &)
}
