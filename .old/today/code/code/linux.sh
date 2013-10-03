#!/bin/bash
info1(){
/home/dao01/

auto eth1
iface eth1 inet dhcp 
                wpa-ssid NAAN-229F
                wpa-psk  00304f85


}
info(){
eth1      IEEE 802.11bg  ESSID:"NAAN-229F"  
          Mode:Managed  Frequency:2.437 GHz  Access Point: 00:30:4F:85:22:9F   
          Bit Rate=54 Mb/s   Tx-Power:24 dBm   
          Retry min limit:7   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality=5/5  Signal level=-37 dBm  Noise level=-57 dBm
          Rx invalid nwid:0  Rx invalid crypt:2  Rx invalid frag:0
          Tx excessive retries:7  Invalid misc:0   Missed beacon:0


sudo cat /home/dao01/tmp/NAAN-229F
[sudo] password for dao01: 
[connection]
id=NAAN-229F
uuid=03de28d5-4288-4ed8-ae7f-5bc889c94172
type=802-11-wireless

[802-11-wireless]
ssid=NAAN-229F
mode=infrastructure
mac-address=00:16:44:7F:44:E6
security=802-11-wireless-security

[802-11-wireless-security]
key-mgmt=wpa-psk
auth-alg=open
psk=00304f85

[ipv4]
method=auto

[ipv6]
method=auto
}


exam(){
http://bash.cyberciti.biz/guide/Category:Exercises
}
bash_manual(){
#bash-faq
http://mywiki.wooledge.org/BashFAQ/
http://bash.cyberciti.biz/guide/Main_Page

#cli args:
http://mywiki.wooledge.org/BashFAQ/035
}

kernel(){
#kernel dependincy graph
lsmod | perl -e 'print "digraph \"lsmod\" {";<>;while(<>){@_=split/\s+/; print "\"$_[0]\" -> \"$_\"\n" for split/,/,$_[3]}print "}"' | dot -Tpng | display -
#listen
tail -f /var/log/syslog | grep network
}

crack(){
xdg-open https://code.google.com/p/backtrack-scripts/source/browse/crack-wifi.sh
}

backup(){
xdg-open http://bash.cyberciti.biz/desktop/linux-or-unix-record-terminal-desktop-sessions/
}

mysql(){
http://bash.cyberciti.biz/backup/backup-mysql-database-server-2/
}
process(){
#background + progress bar:
http://www.ivarch.com/programs/pv.shtml
}
pipe(){
http://bash.cyberciti.biz/guide/Input_and_Output
}
gui(){
http://bash.cyberciti.biz/guide/Zenity:_Shell_Scripting_with_Gnome#Install_zenity_command
}
thatering_3g(){
xdg-open 
}
ssid(){
#stop network-manager first : stop control
#https://help.ubuntu.com/community/WifiDocs/Adhoc
sudo service network-manager stop
sudo ip link set eth1 down
#set up an interface:
sudo iwconfig eth1 essid 'NAAN-229F'

http://www.cyberciti.biz/faq/debian-ubuntu-linux-setting-wireless-access-point/
http://blog.tplus1.com/blog/2008/06/13/how-to-connect-to-a-wireless-network-from-the-ubuntu-command-line/
http://docs.fedoraproject.org/en-US/Fedora/13/html/Wireless_Guide/sect-Wireless_Guide-Fedora_And_Wireless-iwconfig.html
}


pids(){
echo ''
}
roaming(){
http://danielsmedegaardbuus.dk/2006-05-11/wifi-roaming-using-the-shell/
}
ad-hoc(){
http://earthwithsun.com/questions/576661/how-to-join-an-ad-hoc-wireless-network-in-linux
}
singleton(){
http://wiki.bash-hackers.org/howto/mutex
#on pid per script
}
url(){
http://www.debian.org/doc/manuals/debian-reference/ch05.en.html#_gui_network_configuration_tools
http://superuser.com/questions/42460/can-you-explain-how-to-understand-what-the-iwconfig-command-displays-in-ubuntu
http://www.cyberciti.biz/tips/howto-ubuntu-linux-convert-dhcp-network-configuration-to-static-ip-configuration.html

}

history(){
#echo 'connected SSID:'
#sudo iwconfig eth1
#sudo iwconfig eth1 | grep -i --color essid 
#
#iwconfig eth1 essid NAAN-229F key 00304f85
#iwconfig eth1 essid mynet key 16a12bd649ced7ce42ee3f383f

#1
#down vote
#Just edit /etc/network/interfaces and write:
#
#auto wlan0
#iface wlan0 inet dhcp 
#                wpa-ssid <ssid>
#                wpa-psk  <password>
#After that write and close file and use command:
#
#dhclient wlan0
echo ''
}

kill1(){
ps -aux | grep net
#kill -9 X
}

get_ip(){

dhclient help #get new ip
}
solution(){

sudo iwconfig #show connection
ps -aux | grep networking #show process
sudo service network-manager stop #kill deamon
#sudo service network stop #kill deamon
#sudo service networking stop #kill deamon
#assume: eth1 is the interface for the wlan\wifi connection:
#then:

cat /etc/network/interfaces #show configuration for dhcp: ssid/key 
#shows
#auto lo
#iface lo inet loopback
#
#auto eth1
#iface eth1 inet dhcp 
#                wpa-ssid NAAN-229F
#                wpa-psk  00304f85

sudo ifconfig eth1 down
sudo ifconfig eth1 up

sudo dhclient eth1 #get new ip
sudo iwconfig #show connection

}
log(){
echo "print: $1"
sudo ifconfig eth1
sudo iwconfig eth1

}

iwconfig1(){
echo 'define vars: wifi_name wifi_key'
export WIFI_NAME=NAAN-229F
export WIFI_PASSPHRASE=00304f85

echo 'update iwconfig'
sudo iwconfig eth1 essid $WIFI_NAME 
#sudo iwconfig eth1 essid $WIFI_NAME key s:$WIFI_PASSPHRASE

}

cli(){


echo 'ifconfig refresh'
sudo ifconfig eth1 down
iwconfig1
sleep 1
sudo ifconfig eth1 up

echo 'get ip'
#sudo dhclient eth1
#key s:$WIFI_PASSPHRASE
#sudo iwconfig eth1 ap 00:11:50:A0:F2:77
}

manager_up(){
#sudo service networking restart
#sleep 1
sudo service network-manager restart 
}

manager_down(){
#sudo service networking stop
#sleep 1
sudo service network-manager stop
}

steps(){
log 1 
iwconfig1
log 1 
#solution
#cli
#manager_down
#log 2

#manager_up
#log 3
}

edit1(){
sudo gedit /etc/network/interfaces
}
scan(){

sudo iwlist eth1 scan
}

packet(){
icmp solution
}
xterm1(){
tail -f /var/log/syslog | grep network
}

debug1(){
sudo dbus-send --system --print-reply --dest=org.freedesktop.NetworkManager /org/freedesktop/NetworkManager org.freedesktop.NetworkManager.SetLogging string:"info" string:""
#You can find the Network Manager logs in /var/log/syslog, which acts as a catch-all for log messages (unless you have changed rsyslog's default configuration).
}
#edit1
#steps
#scan
log 1
eval $1
log 2
