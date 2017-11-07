FROM docker:stable-dind 

EXPOSE 9000-9010

RUN apk add --no-cache \
 sudo \
 curl \
 git \
 grep \
 screen \
 htop \
 openssh \
 openssl \
 autossh \
 bash \
 bash-doc \
 bash-completion \
 nano \
 tcpdump \
 coreutils \
 py-pip && \
 pip install docker-compose

WORKDIR /data
ENV PS1="SANDBOX :: \W  $ "
RUN echo "sh(){ docker-compose exec \$1 bash ; }" >> /root/.bashrc
CMD dockerd >/dev/null 2>/dev/null