FROM debian:jessie

RUN apt-get update && \
    apt-get -y install rsyslog && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 1514

VOLUME [ "/var/log", "/etc/rsyslog.d" ]

COPY rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT [ "rsyslogd", "-n" ]
