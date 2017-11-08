FROM mayankt/webserver:a
RUN apk add --no-cache bash tcpdump curl
ENV PS1="SERVER-A :: \W  $ "
CMD /bin/sh -c 'nginx'