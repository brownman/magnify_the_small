
pushd `dirname $0` > /dev/null
gedit $done_txt &
gedit $todo_txt &
gedit $ideas_txt &
touch $timing_txt
gedit $timing_txt &
gedit $questions_txt

echo 'update wallpaper?'
read answer
if [ "$answer" = y ]
then

./wallpaper.sh &
fi


popd > /dev/null
exit
