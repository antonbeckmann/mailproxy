#!/bin/bash

#username="$1"
#password="$2"
#mailaddresses="$3"
echo


iparray=($(curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" |  grep -oPm1 "(?<=<title>)[^<]+" | sed '1d')) 
currentIPV4="${iparray[1]}"


set -e
{
	    echo "Hallo Hasenfreunde,"
		echo ""
        echo "die neue Adresse für die Rabbitcam lautet:"
        echo "http://${currentIPV4%?}:8081"
        echo ""
        echo ""
        echo "Viel Freude"
        echo "Anton und Sandra"

        
} > /tmp/email.txt

set -e
{
echo "UseSTARTTLS=YES"
echo "FromLineOverride=YES"
echo "root=admin@example.com"
echo "mailhub=smtp.gmail.com:587"
echo "AuthUser=infotome65000@gmail.com"
echo "AuthPass=${passwort}"        
} > /etc/ssmtp/ssmtp.conf

IFS=',' read -r -a mailarray <<< "$mailaddresses"

for element in "${mailarray[@]}"
do
    sendmail "${element}"  < /tmp/email.txt
done