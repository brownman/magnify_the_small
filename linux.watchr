#!/bin/bash
#pushd `dirname $0` > /dev/null



# This is for automatically compiling .coffee to .js 
#
#watch('koans\/.*\.coffee') {|match| system "cake build"}

# This compiles the completed koans dir 
# I'm using this for testing

#watch('completed-koans\/.*\.coffee') {|match| system "cake test"}

#watch('src\/.*\.sh') {|match| system "./meditate.sh"}

watch('testing/python2/koans\/.*\.py') {|match| system "./testing/python2/run.sh"}
watch('testing/python2/runner\/.*\.py') {|match| system "./testing/python2/run.sh"}


watch('prespective\/.*\.sh') {|match| system "./testing/python2/run.sh"}
#
watch('prespective/public/libs/yaml/blank.yaml') {|match| system "./testing/python2/run.sh"}
watch('prespective/public/libs/cfg\/.*\.cfg') {|match| system "./testing/python2/run.sh"}

watch('website\/.*\.js') {|match| system "./testing/python2/run.sh"}
#
#watch('prespective/public\/.*\.sh') {|match| system "./testing/python2/run.sh"}


#watch('runner\/.*\.py') {|match| system "./run.sh"}


#watch('tmp/word1.txt') {|match| system "./meditate"}



#popd > /dev/null
#exit
