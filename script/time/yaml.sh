#!/bin/bash

# about file:
# extruct yaml to dirs: tmp OR cfg 


notify-send 'yaml.sh'

#export COMMANDER=true

parse_subject(){
trace  "parse subject $1"
local subject="$1"
local file_to=$DATA_DIR/tmp/${subject}.tmp
echo '' >  $file_to

local cmd=$( echo "cat $file_data | shyaml get-values $subject" )
local results=$(eval "$cmd")

echo "$results" > $file_to

}

unpack_subject(){
local subject="$1"
local file=$DATA_DIR/tmp/${subject}.tmp
        local lines=()
        file_to_lines $file
    echo -n '' > $file #replace file's content
        local cmd='line_strip "$line" $file'
    execute_lines 
}


parse_subject workflow
#parse_subject story
#parse_subject cake

parse_subject testing 

parse_subject tasks 

parse_subject 'times'
parse_subject notes 

parse_subject activity 
#assert_equal_str 
flite 'activity file'
gxmessage $GXMESSAGET -file "$DATA_DIR/tmp/activity.tmp" -title 'activity.tmp:'

#
#unpack_subject  story
#unpack_subject  cake 
#




