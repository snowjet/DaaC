#FROM centos:7
FROM centos:7

LABEL io.openshift.expose-services="4822:http"

ENV GUACD_LOG_LEVEL=info

USER root

ADD common/config /tmp/config

RUN yum update -y && \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum --enablerepo=epel-testing install -y guacd libguac{,-client*} liberation-fonts dejavu-sans-mono-font terminus-fonts freerdp-plugins freerdp-libs ghostscript  && \
    mkdir -p /etc/guacamole && \
    mkdir -p /home/user && \
    chown -R root:root /home/user && \
    useradd user -u 10001 -g 0 -d /home/user -G wheel,tty && \
    chmod 770 /home/user && \
    chown -R user:0 /home/use && \
    yum autoremove -y; \
    yum clean all; \
    rm -rf /var/cache/yum; \
    rm -rf /tmp/*.sh; \
    rm -rf /tmp/config; \
    rm -f /var/log/*.log

USER 10001
WORKDIR /home/user
EXPOSE 4822
ENTRYPOINT guacd -b 0.0.0.0 -L $GUACD_LOG_LEVEL -f
