FROM mayankt/webserver:b
RUN apk add --no-cache bash tcpdump curl
ENV PS1="SERVER-B :: \W  $ "
CMD /bin/sh -c 'nginx'