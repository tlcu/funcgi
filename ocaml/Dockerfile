FROM alpine:latest
RUN apk --update add --no-cache mini_httpd ocaml; \
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
