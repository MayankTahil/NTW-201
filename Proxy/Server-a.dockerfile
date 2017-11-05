FROM mayankt/webserver:a
RUN apk add --no-cache bash tcpdump curl
CMD /bin/sh -c 'nginx'