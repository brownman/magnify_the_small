#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE

PS3="Blogging:" 
options=( "Quit" "Blog" )


reset
select opt in "${options[@]}"
do

    case $opt in
        "Quit")
            exiting
            ;;


        "Blog")
            echo '~/.bash_it/blog/brownman.github.com'
            echo 'Jakyll serve'
            echo 'rake post title="day X: goal X"'
            ;;


        *)
            reset
            ;;
    esac
done

popd > /dev/null
exit
