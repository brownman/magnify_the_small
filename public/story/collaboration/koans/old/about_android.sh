#!/bin/bash -x
yellow "android operations"
red 'scattering ?!'
#Chapter 7. Setting Up System Bootscripts'


test_adb() {

#local str=`cat /etc/udev/rules.d/70-persistent-net.rules`
#echo sleep
#sleep 2s

  #local output=`echo 1+1`
  #echo $output
  #assertEqual $output '1+1' 

  #local output2=$((1+1))

  #assertEqual $output2 '2'
#local command='cat /etc/udev/rules.d/70-persistent-net.rules'
#local str=`$command`
#echo "echooo $str"
assertEqual 1 1 #fine
}
