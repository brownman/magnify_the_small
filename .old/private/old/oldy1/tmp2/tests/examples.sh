#!/bin/bash
array(){
array=( a b c d e f g h i j k l ) ## define array

unset array[0]              ## remove element
array=( "${array[@]}" )     ## pack array

printf "%s\n" "${array[@]}"
}
 ## print array

array
exit
