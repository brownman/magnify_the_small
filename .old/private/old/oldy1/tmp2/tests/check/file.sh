#echo "file1 got args:  $@"
func1(){
echo "1:$1" 
echo "2:$2"
}
#$1 "$2" "$3" "$4" "$5" 
echo '**'
eval  $@
#export -f func1

