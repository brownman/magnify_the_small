
#echo 'edit .txt ?'

pushd `dirname $0` > /dev/null

answer=$( messageYN 'edit.sh' 'edit .txt ?' )
#read answer
if [ "$answer" = 2 ]
then

gedit $todo_txt &
gedit $done_txt &
gedit $rules_txt &
gedit $timing_txt 

#gedit $job_txt &
#gedit $product_txt 
#gedit $readme_txt 
#gedit $ideas_txt &
#gedit $questions_txt &
#gedit $glossary_txt &
#gedit $efficiency_txt &
#gedit $commitment_txt &
#gedit $motivations_txt 
fi

#echo 'update wallpaper?'
#read answer


answer=$( messageYN 'edit.sh' 'update wallpaper ?' )
if [ "$answer" = 2 ]
then

$TASKS_DIR/wallpaper.sh &
fi

answer=$( messageYN 'edit.sh' 'update schedule ?' )
if [ "$answer" = 2 ]
then

     ( xdg-open https://www.google.com/calendar/render?tab=mc &)
     ( xdg-open https://mail.google.com/tasks/ig?pli=1 &)

fi





popd > /dev/null
#exit
