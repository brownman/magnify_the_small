file_name=/tmp/gcalcli_agenda.txt

file_name2=/tmp/gcalcli_agenda_full.txt

#gcalcli --cal brownman-calendar --nc agenda "`date`" "`date --date='23:59'`" > $file_name2 

#gcalcli --cal brownman-calendar --nc agenda "`date --date='01:00'`" "`date --date='23:59'`" > $file_name2 

gcalcli --cal brownman-calendar --nc --ignore-started agenda "`date --date='08:00am'`" "`date --date='23:59'`" > $file_name 
cat $file_name
gcalcli --cal brownman-calendar --nc --ignore-started agenda "`date --date='08:00am'`" "`date --date='23:59'`" > $file_name2 


#gcalcli --https --cal brownman-calendar --nc agenda "`date`" "`date --date='1 day ago'`" > $file_name2 


#gcalcli --cal brownman-calendar --nc agenda "`date`" "`date --date='1 day ago'`"

#cat $file_name | head -20 # | awk -F 'pm' '{print $1}' #> /tmp/pm.txt  #| sed 's/\\n//g' | sed 's/"//g' > list.txt

#cat $file_name | head -6 | awk -F am '{print $2}' | grep - > /tmp/am.txt  #| sed 's/\\n//g' | sed 's/"//g' > list.txt
#cat $file_name | head -6 | awk -F pm '{print $2}' | grep - > /tmp/pm.txt  #| sed 's/\\n//g' | sed 's/"//g' > list.txt

#cat /tmp/am.txt > /tmp/ampm.txt
#cat /tmp/pm.txt >> /tmp/ampm.txt



#echo 'fetch: google-calendar'  "$file_name"
