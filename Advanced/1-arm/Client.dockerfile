FROM ubuntu:latest

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
      traceroute \
      net-tools \
      inetutils-ping \
      tcpdump \
      curl \
      wget \
      dnsutils && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*