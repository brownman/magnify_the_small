#!/bin/bash
notify-send 'meditate..'
echo 'meditate'
# Setup
mkdir -p tmp
rm -rf bin/*
mkdir -p bin
echo 'C program for getting the environment variable'
gcc -o bin/variable_check support/variable_check.c
gcc -o bin/output_stderr support/output_stderr.c
gcc -o bin/output_stdout support/output_stdout.c
gcc -o bin/output_both support/output_both.c


echo ' Load all files in support'
for file in `ls support | grep .sh`; do
  source support/$file
done

echo 'Load all files in src'
for file in `ls src | grep .sh`; do
  source src/$file

  # OMG this is a bash test runner!! <3 <3 <3
  # functions=`declare -F | cut -d ' ' -f 3 | grep ^test_`
  echo  'This style allows us to run tests in order'
  functions=`grep -h test_ src/$file | cut -d '(' -f 1`
  for i in $functions; do
    #rm -rf tmp/*
    $i
    green "  $i"
  done

done

