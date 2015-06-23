#!/bin/bash

LOG_FILE=/var/log/nintendozone_hostapd.log

service hostapd stop >> $LOG_FILE
killall hostapd >> $LOG_FILE

MAC_FILE=/etc/hostapd/mac_nintendozone

#  Set location for temporary config file, located in the /dev/shm/ RAMdisk
CONFIG_FILE=/dev/shm/nintendozone.conf

#  Find a random Nintendozone from our MAC_FILE
sort -R $MAC_FILE | head -n 1 | read MAC SSID

#  Run hostapd with a conf file that we generate on the fly
#  Do not tab this next section in, or you will have a broken config file
cat > $CONFIG_FILE <<_EOF_
interface=wlan0
bridge=br0
driver=nl80211
ssid=$SSID
bssid=$MAC
hw_mode=g
channel=6
auth_algs=1
wpa=0
macaddr_acl=1
accept_mac_file=/etc/hostapd/hostapd.accept
logger_syslog=-1
logger_syslog_level=2
wmm_enabled=0
ignore_broadcast_ssid=0
_EOF_

echo "Current time:" $(date -u)"- SSID:" $SSID "- BSSID:" $MAC >> $LOG_FILE

#  Launch the wireless broadcaster with everything we just made in background mode
hostapd -B $CONFIG_FILE >> $LOG_FILE