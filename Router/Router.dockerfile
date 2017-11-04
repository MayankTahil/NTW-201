FROM ubuntu:16.04
MAINTAINER bouroo <bouroo@gmail.com>

# Change root password
RUN echo root:pass | chpasswd
RUN echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" >/etc/apt/apt.conf.d/docker-gzip-indexes
# Add some package
RUN apt-get update && apt-get install -y wget locales nano tcpdump ntpdate
# Add locale
RUN locale-gen en_US.UTF-8 && locale-gen th_TH.UTF-8 en_US en_US.UTF-8 && dpkg-reconfigure locales
# Add webmin repository key
RUN wget http://www.webmin.com/jcameron-key.asc && apt-key add jcameron-key.asc
# Add webmin repository
RUN echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list
# Update OS
RUN apt-get update && apt-get dist-upgrade -y
# Install webmin and clean file
RUN	echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections && \
		echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections && \
		mkdir /etc/iptables && touch /etc/iptables/rules.v6 && touch touch /etc/iptables/rules.v4 && \
		apt-get install -y shorewall iptables-persistent webmin && \
		apt-get autoclean

RUN echo "root: firewall system-status net" > /etc/webmin/webmin.acl

ENV LC_ALL en_US.UTF-8

EXPOSE 10000

# VOLUME ["/etc/webmin"]
ADD ./data/iptables.up.rules /etc/iptables.up.rules

CMD /usr/bin/touch /var/webmin/miniserv.log && /usr/sbin/service webmin restart && /usr/bin/tail -f /var/webmin/miniserv.log