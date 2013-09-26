cd ../public

file1=$PWD/libs/cfg/vars.cfg
file2=$PWD/libs/cfg/funcs.cfg
notify-send "cfg file" "$file"

#export CFG=$file
#ls -l $file
#
. $file1
. $file2

