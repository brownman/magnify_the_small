
#echo 'edit .txt ?'

pushd `dirname $0` > /dev/null

answer=$( messageYN 'edit.sh' 'edit .txt ?' )
#read answer
if [ "$answer" = 2 ]
then



gedit $done_txt &
gedit $todo_txt &
gedit $ideas_txt &
gedit $timing_txt &
gedit $questions_txt &
gedit $glossary_txt &
gedit $project_txt &
gedit $motivations_txt 
fi

#echo 'update wallpaper?'
#read answer


answer=$( messageYN 'edit.sh' 'update wallpaper ?' )
if [ "$answer" = 2 ]
then

$TIMER2_DIR/wallpaper.sh &
fi


popd > /dev/null
#exit
