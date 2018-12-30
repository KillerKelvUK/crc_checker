#!/bin/bash

clear
number=1
while [ $number -ne 0 ]; do
    values=$(ssh kelvin@192.168.1.1 '/usr/sbin/nvram get dsllog_crcdown; echo "|"; /usr/sbin/nvram get dsllog_snrmargindown; echo "|"; /usr/sbin/nvram get dsllog_dataratedown')
    echo $(date) "|" $values >> /home/kelvin/crc-checker/output
    echo Loop $number completed
    echo -en "Press q to exit or s to snapshot \t\t: "; echo
    read -t 300 key
    if [ "$key" = "q" ]; then
        number=0
        echo "quit"
    elif [ "$key" = "s" ]; then
        cp /home/kelvin/crc-checker/output /mnt/share/Downloads/"$(date) - snapshot"
        echo Snapshot written
    else
        number=$(($number + 1))
    fi
done

