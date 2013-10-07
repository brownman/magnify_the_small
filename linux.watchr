#!/bin/bash



# This is for automatically compiling .coffee to .js 
#
#watch('koans\/.*\.coffee') {|match| system "cake build"}

# This compiles the completed koans dir 
# I'm using this for testing

#watch('completed-koans\/.*\.coffee') {|match| system "cake test"}

#watch('src\/.*\.sh') {|match| system "./meditate.sh"}


#watch('prespective/public/libs/tmp/testing.tmp') { |match| system "./testing/python2/run.sh"}



#
#watch('prespective/public/libs/yaml/blank.yaml') {|match| system "./testing/python2/run.sh"}



#watch('prespective/public/libs/tmp/testing.tmp') {|match| system "./prespective/scripts/test.sh"}



#watch('website\/.*\.js') {|match| system "./testing/python2/run.sh"}
#
#watch('prespective/public\/.*\.sh') {|match| system "./testing/python2/run.sh"}


#watch('runner\/.*\.py') {|match| system "./run.sh"}


#watch('tmp/word1.txt') {|match| system "./meditate"}




watch('1/testing/python2/koans\/.*\.py') {|match| system "./1/testing/python2/run.sh"}
watch('1/testing/python2/runner\/.*\.py') {|match| system "./1/testing/python2/run.sh"}







watch('.*\.sh') {|match| system "./1/testing/python2/run.sh"}
watch('.*\.cfg') {|match| system "./1/testing/python2/run.sh"}
##watch('script\/.*\.sh') {|match| system "./1/testing/python2/run.sh"}
watch('data/yaml/one.yaml') {|match| system "./genius.sh yaml"}

watch('data/tmp/testing.tmp') {|match| system  "./1/testing/python2/run.sh"}

#watch('prespective/public/libs/cfg\/.*\.cfg') {|match| system "./testing/python2/run.sh"}
