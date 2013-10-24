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

show_keys(){
local keys1=$(cat $file_data | shyaml keys)
#echo ${keys1} | xargs notify-send
#"show_keys:"

        IFS='|' read -a columns <<< "$keys1"

        count=0
        for key in ${keys1[@]}; do

        trace "parse subject: $key" 
parse_subject "$key"

##mantion_file "$file"
            done


echo "show keys: $keys1"
}
show_keys
update_db_list
 

#
#unpack_subject  story
#unpack_subject  cake 
#




