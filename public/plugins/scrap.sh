

scrap_something(){
#.echo("Usage: $ casperjs googlepagination.js my search terms")

local dir=/TORRENTS/JAVASCRIPT/casperjs
local prog=$dir/commands.sh
#local prog="$dir/bin/casperjs"
#local script="$dir/samples/translate.js"


local args1="$1" #"--target=${1}" #ru
local args2="$2" #'my dogs'

#local result=$( $prog $script $args1 "$args2" )
exec $prog $args1 "$args2" &
#gxmessage -title "scraping result:" "$result" $GXMESSAGE1

#( gedit "$script" &)
#echo "$result"
}


scrap_practice(){
    cyan "idea for practive scraping"
    local title='scraping idea ?'
    while :;do
        answer=$( gxmessage  -buttons "ok"  -entry -title "$title"  -file  $scrap_txt -ontop -timeout $TIMEOUT1 )
        if [ "$answer" = '' ];then
            break
        else 
            update_file $scrap_txt "$answer"
        fi
    done
}


