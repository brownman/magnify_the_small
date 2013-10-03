#!/bin/bash

# about file:
# extruct yaml to dirs: tmp OR cfg 


pushd `dirname $0` > /dev/null
. loader.sh
notify-send 'yaml.sh'
parse_subject(){
trace  "parse subject $1"
local subject="$1"
local file_to=$CFG_DIR/tmp/${subject}.tmp
echo '' >  $file_to

local cmd=$( echo "cat $file_data | shyaml get-values $subject" )
local results=$(commander "$cmd")

echo "$results" > $file_to

}

unpack_subject(){
local subject="$1"
local file=$CFG_DIR/tmp/${subject}.tmp
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
#
#unpack_subject  story
#unpack_subject  cake 
#
popd > /dev/null
exit 0



