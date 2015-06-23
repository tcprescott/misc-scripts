### BEGIN INIT INFO
# Provides:          homepass
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       Start nintendozone HostAPD script
### END INIT INFO

start() {
        echo "Starting nintendozone"
        nohup /etc/hostapd/nintendozone.sh > /var/log/nintendozone_hostapd.log &
}

stop() {
        echo "Killing nintendozone"
        kill -9 `ps aux|grep nintendo|grep -v grep|awk '{print $2}'`
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  retart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|uninstall}"
esac