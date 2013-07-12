green "Arithmetic evaluation"

test_arithmetic_evaluation() {

  local output=`echo 1+1`
  echo $output
  assertEqual $output '1+1' 

  #local output2=$((1+1))

  #assertEqual $output2 '2'
}
test_operators(){


a=24
b=47

if [ "$a" -eq 24 ] && [ "$b" -eq 47 ]
then
  echo "Test #1 succeeds."
else
  echo "Test #1 fails."
fi

# ERROR:   if [ "$a" -eq 24 && "$b" -eq 47 ]
#+         attempts to execute  ' [ "$a" -eq 24 '
#+         and fails to finding matching ']'.
#
#  Note:  if [[ $a -eq 24 && $b -eq 24 ]]  works.
#  The double-bracket if-test is more flexible
#+ than the single-bracket version.       
#    (The "&&" has a different meaning in line 17 than in line 6.)
#    Thanks, Stephane Chazelas, for pointing this out.


if [ "$a" -eq 98 ] || [ "$b" -eq 47 ]
then
  echo "Test #2 succeeds."
else
  echo "Test #2 fails."
fi


#  The -a and -o options provide
#+ an alternative compound condition test.
#  Thanks to Patrick Callahan for pointing this out.


if [ "$a" -eq 24 -a "$b" -eq 47 ]
then
  echo "Test #3 succeeds."
else
  echo "Test #3 fails."
fi


if [ "$a" -eq 98 -o "$b" -eq 47 ]
then
  echo "Test #4 succeeds."
else
  echo "Test #4 fails."
fi


a=rhino
b=crocodile
if [ "$a" = rhino ] && [ "$b" = crocodile ]
then
  echo "Test #5 succeeds."
else
  echo "Test #5 fails."
fi


#test [ "$a" -eq 24 -a "$b" -eq 47 ]
#Arithmetic tests

#Operator syntax	Description
#<INTEGER1> -eq <INTEGER2>	True, if the integers are equal.
#result=[ 3 -lt 9 ]
#result=$?


[ 1 -gt 2 ]
result=`echo $?`
echo "$result"
#declare -i num
#num=`echo 1`
num=1
assertEqual $num $result

}
#http://wiki.bash-hackers.org/commands/classictest

