
test_learning() {


assertEqual 1 1 #fine
}
test_debian_package(){
cd /TORRENTS/CODE/test_package 
#commands.sh step1
#/TORRENTS/CODE/test_package/
./commands.sh step1
result="$?"

assertEqual $result 1 'all tests are ok'

}
