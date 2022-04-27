FROM debian:buster

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y python3 sudo bash ca-certificates iproute2 python3-apt aptitude systemd systemd-sysv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

RUN systemctl set-default multi-user.target

CMD [ "/lib/systemd/systemd", "log-level=info", "unit=sysinit.target" ]
