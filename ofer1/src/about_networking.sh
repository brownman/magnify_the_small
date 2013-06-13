#!/bin/bash -x
yellow "network operations"
red 'Chapter 7. Setting Up System Bootscripts'
red 'how to get the internet provider ip ?'
red 'how to bring up eth1 ?'
red 'which drivers are in use?'
red 'why should I use & for not breaking the thread?'

#echo 'http://www.linuxfromscratch.org/blfs/view/development/chapter07/network.html'
#echo '7.13.1. Creating stable names for network interfaces'
#echo '7.13.2. Creating Network Interface Configuration Files'
#echo '7.13.3. Creating the /etc/resolv.conf File'


test_my_drivers() {

#local str=`cat /etc/udev/rules.d/70-persistent-net.rules`
#echo sleep
#sleep 2s

  #local output=`echo 1+1`
  #echo $output
  #assertEqual $output '1+1' 

  #local output2=$((1+1))

  #assertEqual $output2 '2'
local command='cat /etc/udev/rules.d/70-persistent-net.rules'
local str=`$command`
#echo "echooo $str"
#results="$str"
results=`echo "$str"`


#assertEqual '1'  '1' 'nice 2' 

#assertEqual '1'  '1'  

assertMatch "$results"  'b43-pci-bridge' & #'nice 1' &

echo "return ? $?"




}


test_my_mac_address() {
sleep 2s 
local command='grep -H . /sys/class/net/*/address'
local str=`$command`
result=`echo "$str"` # | grep -o eth1`

# "command: \n $command"
#blue "$result"

assertMatch "$result" 'eth1' #'nice 2'

}



