
pushd `dirname $0` > /dev/null
text_file=~/tmp/timer2/daily/todo.txt
gedit $text_file
#$tpng $background $text_file 1250 930 1300x 33 yellow true
text_file=~/tmp/timer2/daily/done.txt
gedit $text_file
#$tpng $background $text_file 450 630 1300x 63 white true

./wallpaper.sh
popd > /dev/null
exit
