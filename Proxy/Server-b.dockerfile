FROM mayankt/webserver:b
ENV PS1="SERVER-B :: \W  $ "
RUN apk add --no-cache bash tcpdump curl
CMD /bin/sh -c 'nginx'