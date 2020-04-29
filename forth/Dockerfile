FROM alpine:edge
RUN echo https://dl-4.alpinelinux.org/alpine/edge/main > /etc/apk/repositories; \
    echo https://dl-4.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories; \
    echo https://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories; \
    apk --update add --no-cache mini_httpd gforth; \
    addgroup -S feeble \
    && adduser -S weakling -G feeble
EXPOSE 1337
VOLUME /var/www/localhost/htdocs
USER weakling
ENTRYPOINT [\
 "mini_httpd", \
 "-C", "/etc/mini_httpd/mini_httpd.conf", \
 "-c", "cgi-bin/*", \
 "-l", "/dev/stdout", \
 "-p", "1337", \
 "-D" \
]
