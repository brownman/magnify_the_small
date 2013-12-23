


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



#watch('1/website\/.*\.js') {|match| system "./1/testing/python2/run.sh"}
#
#watch('prespective/public\/.*\.sh') {|match| system "./testing/python2/run.sh"}


#watch('runner\/.*\.py') {|match| system "./run.sh"}


#watch('tmp/word1.txt') {|match| system "./meditate"}

##watch('script\/.*\.sh') {|match| system "./1/testing/python2/run.sh"}

#watch('prespective/public/libs/cfg\/.*\.cfg') {|match| system "./testing/python2/run.sh"}
#~/magnify_the_small/1/others/CODE/devscripts-2.13.1/test


#watch('**/.*\.js') {|match| system "./script/single.sh motivation"}





watch('data/yaml/one.yaml') {|match| system "bash -e ./genius.sh yaml"}

watch('data/txt/error.txt') {|match| system "bash -e ./genius.sh simple_notification error"}
#watch('data/tmp/wallpaper.tmp') {|match| system "bash -e ./genius.sh single wallpaper"}

#watch('data/yaml/one.yaml') {|match| system "./1/testing/python2/run.sh"}
#

watch('1/testing/python2/koans\/.*\.py') {|match| system "bash -e ./1/testing/python2/run.sh"}
watch('bugs/bash_koans/src\/.*\.sh') {|match| system "bash -e bugs/bash_koans/meditate"}


watch('script/cfg\/.*\.cfg') {|match| system "bash -e ./genius.sh simple_notification"}
watch('script/tasks/plugins\/.*\.sh') {|match| system "bash -e ./genius.sh simple_notification"}


watch('script/time/test.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}

watch('script/tasks/tasker.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
watch('script/tasks/plugins/db.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
#watch('1/testing/python2/runner\/.*\.py') {|match| system "./1/testing/python2/run.sh"}
#


watch('genius.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
#watch('.\/*\.sh') {|match| system "./1/testing/python2/run.sh"}

#watch('.*\.sh') {|match| system "./1/testing/python2/run.sh"}

#watch('script/cfg/*.cfg') {|match| system "./genius.sh yaml"}
#watch('script/cfg/*.cfg') {|match| system "./genius.sh simple_notification"}
#'script/test_.*\.rb' 
#
watch('data/txt/testing.txt') {|match| system  "bash -e ./1/testing/python2/run.sh"}

#watch('1/*\/.*\.js') {|match| system "./1/testing/python2/run.sh"}
#watch('./*\/.*\.sh') {|match| system "./1/testing/python2/run.sh"}
