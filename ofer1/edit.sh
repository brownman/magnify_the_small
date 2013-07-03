
echo 'edit .txt ?'
read answer
if [ "$answer" = y ]
then


pushd `dirname $0` > /dev/null
gedit $done_txt &
gedit $todo_txt &
gedit $ideas_txt &
touch $timing_txt
gedit $timing_txt &
gedit $questions_txt &
gedit $glossary_txt &
gedit $motivations_txt 
fi

echo 'update wallpaper?'
read answer
if [ "$answer" = y ]
then

$TIMER2_DIR/wallpaper.sh &
fi


popd > /dev/null
#exit
