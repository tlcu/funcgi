FROM alpine:latest
ADD tclkit.tar.gz /usr/bin/tclsh
RUN apk --update add --no-cache mini_httpd; \
      addgroup -S feeble \
      && adduser -S weakling -G feeble
EXPOSE 1337
VOLUME /var/www/localhost/htdocs
ENV LC_CTYPE UTF-8
USER weakling
ENTRYPOINT [\
 "mini_httpd", \
 "-C", "/etc/mini_httpd/mini_httpd.conf", \
 "-c", "cgi-bin/*", \
 "-l", "/dev/stdout", \
 "-p", "1337", \
 "-D" \
]
