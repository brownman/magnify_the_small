#http://wiki.bash-hackers.org/commands/builtin/exec

#myprog=/bin/ls
myprog=./file.sh
echo "This is the wrapper script, it will exec $myprog"
 
# do some vodoo here, probably change the arguments etc.
# well, stuff a wrapper is there for
 
#exec "$myprog" "$@"

#args1="func1 '2 words' 2"
#echo  $args1
#args1=`echo "func1 '2 words' 2"`

#exec $myprog "$?"
#{args}

$myprog 'func1 "2 words" 2'
#exec "$myprog" 'func1 "2 words" 2'
