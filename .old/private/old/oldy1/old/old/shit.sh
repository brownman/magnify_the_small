IIIIiii
so you think you can do it better then me
you can laugth now but you will regret it
you are laughing now
can you be less contented
I know something that you don't 
you know what - let's have a deal


exiting

old_IFS=$IFS
IFS=$'\n'
lines=($(cat $philo_txt)) # array
IFS=$old_IFS



exiting
for var in "${ArrayName[@]}"
do
  echo "${var}"
  # do something on $var
done
exiting
N=0
while read LINE ; do
    N=$((N+1))
    echo "$N.  $LINE ?"
    echo4 "$LINE"
    read answer

    echo4 "$answer"
done < $philo_txt
}



old_IFS=$IFS
IFS=$'\n'
lines=($(cat $philo_txt)) # array
IFS=$old_IFS
for var in "${lines[@]}"
do
  echo "${var}"
  # do something on $var
done


exiting
echo ${line[1]} # will echo line number 4 (line numbering start with 0)
exiting
for I in $(lines);do
 echo "$I"
done
#sleep1 3

thought="$1"
command="$2"
answer="$command \# $tought"


message1() {
    cyan "~ Dream First ~"
    white "Imagine easiness.."
    white "only then.."
    sleep1 3
    yellow " ACT !"
    update_file  $repl_sh "$answer"

}

reset
if [ "$thought" = '' ];then
    cyan "Help:"
    white  "please supply: 'command' 'thought' ''"

    cat $repl_sh
    exit 1
else
    message1
    eval "$answer"
    red "$?"
    green "try harder my lad !"
fi


blue "should I record you ?"

white 'make presentation aday - js inheritance'
