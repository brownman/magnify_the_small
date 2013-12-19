#!/bin/bash
#http://www.imagemagick.org/Usage/text/#pango_markup

notify-send1 'wallapaper' 'plugin'

file_original=/usr/share/xfce4/backdrops/xubuntu-precise-right.png
file_before=/tmp/before.png #copy of the original
file_after=/tmp/after.png #compose: txt_image + background
file_text_image=/tmp/text.png #convert txt to image
file_txt=$file_logger
#$DATA_DIR/txt/efficiency.txt
#file_txt=~/tmp/1.txt


split_txt(){
    #gedit $file_txt
    # file to lines
    # line with pattern X -> 
   trace '' 
}

run(){
backup
    #show $file_before
    #gedit $file_txt
    trigger
cmd="show $file_after"
optional "$cmd"
    replace
}


trigger(){

    generate $file_before $file_txt $x $y $size $point_size $color $override
    #generate $file_before $file_txt 1130 150 600x 13 white true
}

generate(){
    echo 'generate new text on the background'
    echo -e "background:$1 \n text_file:$2 \n x:$3 y:$4 \n size:$5 \n point_size:$6"
    background=$1 # /tmp/background.png
    text_file=$2 #  /tmp/next.txt 
    x=$3 #850
    y=$4  #350
    size=$5 #200x
    point_size=$6 #25
    color=$7
    override=$8
    #generate text:
    cat $text_file | head -6 |    convert -background none  -fill $color -size $size  -pointsize $point_size caption:@-  $file_text_image
    composite -geometry "+$x+$y" $file_text_image $background $file_after 
}

playground(){
    #generate static:
    text_image=/tmp/text.png
    if [[ $override = 'true' ]]
    then
        result=/tmp/result.png
    else
        cp /tmp/result.png /tmp/temp.png
        result=/tmp/temp.png
    fi
}
backup(){
    notify-send1 'backup'
    #src=xfce-transparent.png
    #file1="/usr/share/xfce4/backdrops/${src}"
    #file1="/tmp/mm.png"
    #usr/share/xfce4/backdrops/${src}"
    #cp ~/Pictures/lubuntu-default-wallpaper-2.png /tmp/result.png
    cp $file_original $file_before
}
replace(){
    #update xfce desktop
    notify-send3 'update wallaper' 
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/Pictures/lubuntu-default-wallpaper-2.png 
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file_after
    #xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file_after
}
show(){
    result=$1
    xloadimage $result
}













run
