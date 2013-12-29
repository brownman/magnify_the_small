cronT(){
    trace 'tail'

cmd="tail -f /var/log/syslog | grep CRON"
#echo "$cmd"
cmd1="xterm -e $cmd"
detach  "$cmd1"
}
cronE(){

    export EDITOR=/usr/bin/gedit
    trace 'edit cron jobs'
    cmd="crontab -e"
    detach "$cmd"
    echo  'cron service is alive ?'
}

cronA(){
#flite 'cron a'
#    notify-send1 'cron' 'is running'
#    sleep1 1
#    update_points "cron job - A" 'cron'
    tasker suspend2
}
cronB(){
    flite 'cron b'

    update_points "cron job - B" 'cron'
    notify-send3 "cron is alive $time1"
}


