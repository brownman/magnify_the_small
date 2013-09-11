#str='method'
dir=testing/python2/koans
newer=recent_koan.py

step1(){
#local str="$1"
ans1=$(gxmessage "grep for:" -entry)
#echo "$ans1"
res=$(ls -1 $dir | grep "$ans1")
#echo "$res"
ans=$(gxmessage "$res" -entrytext "$ans1" )
echo "$ans"
}

step2(){
local str="$1"
ln -sf $dir/$str $newer
ls -l $newer
cat $newer | head -10
}

steps(){
ans1=$(step1)
echo "creating symlink for: $ans1"
sleep 3
step2 "$ans1"
}
steps
