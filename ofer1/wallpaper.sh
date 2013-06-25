tpng=txt_to_png.sh
src=xfce-transparent.png
file1="/usr/share/xfce4/backdrops/${src}"
#cp ~/Pictures/lubuntu-default-wallpaper-2.png /tmp/result.png
cp $file1 /tmp/result.png
#str=$(head -4 /tmp/gcalcli_agenda.txt | tail -3)

#echo -e "$str" > /tmp/next.txt

date | awk -F ' ' '{print $4}' > /tmp/date.txt
background=/tmp/result.png
#text_file=/tmp/missions.txt
#/TORRENTS/SCRIPTS/EXEC/txt_to_png.sh $background $text_file 900 250 600x 15 black true

#text_file=/tmp/ampm.txt
#/TORRENTS/SCRIPTS/EXEC/txt_to_png.sh $background $text_file 400 750 900x 20 black true

text_file=~/tmp/timer2/daily/todo.txt
#gedit $text_file
$tpng $background $text_file 450 830 1300x 33 white true
text_file=~/tmp/timer2/daily/done.txt
#gedit $text_file
$tpng $background $text_file 450 430 1300x 63 yellow true

text_file=/tmp/gcalcli_agenda.txt
$tpng $background $text_file 40 150 600x 13 white true


#text_file=~/tmp/ofer/weekly/todo.txt
#$tpng $background $text_file 600 230 600x 23 black true
#
#
#
text_file=/tmp/missions.txt
#tmp/ofer/daily/now.txt
$tpng $background $text_file 1130 150 600x 13 white true
#

#
#text_file=~/tmp/ofer/daily/thanks.txt
#$tpng $background $text_file 550 790 600x 20 black true
#
#text_file=~/tmp/ofer/weekly/rules.txt
#$tpng $background $text_file 1100 830 500x 23 pink true
#
##text_file=~/tmp/ofer/essay.txt
##/TORRENTS/SCRIPTS/EXEC/txt_to_png.sh $background $text_file 50 30 500x 33 green true
#
#text_file=/tmp/date.txt
#$tpng $background $text_file 190 490 400x 70 yellow true
#
#
exit





