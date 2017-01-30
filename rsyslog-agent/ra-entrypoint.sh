#!/bin/bash

template=${FORWARD_TEMPLATE:-*.*}
server=${RSYSLOG_SERVER:-rsyslog-server}

echo "$template  @@$server:1514" >> /etc/rsyslog.conf

exec /usr/sbin/rsyslogd -n
