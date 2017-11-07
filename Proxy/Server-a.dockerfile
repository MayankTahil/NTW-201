FROM mayankt/webserver:a
ENV PS1="SERVER-A :: \W  $ "
RUN apk add --no-cache bash tcpdump curl
CMD /bin/sh -c 'nginx'