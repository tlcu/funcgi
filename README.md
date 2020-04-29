# funcgi

Simple web programming.

![](https://upload.wikimedia.org/wikipedia/en/c/cd/CGIlogo.gif)

Frustrated with modern web development worst practices?

Sick of Evil Corp.™ 'services'?

Interested in scaling _down_ to a personal, hackable web?

Have fun with [CGI]!

## Flavors

Besides dropping amd64 linux binaries in `www/cgi-bin/`, a number of
flavors are available with interpreters pre-installed:

| Image    | Description                                   | Size (MB) |
| ---------| --------------------------------------------- | --------- |
| base     | barebones [BusyBox] environment               | 5.73      |
| [forth]  | _the_ stack based programming language        | 8.36      |
| [guile]  | scheme dialect / GNU extension language       | 18.9      |
| [jim]    | small-footprint yet full-featured Tcl dialect | 10.1      |
| [lua]    | lightweight, embeddable scripting language    | 6.09      |
| [perl]   | 25,000 extensions on CPAN                     | 39.9      |
| [python] | popular and easy-to-learn                     | 58.6      |
| [ruby]   | 'Ruby is designed to make programmers happy'  | 24.3      |
| [tcl]    | Tool Command Language, batteries included     | 20.6      |

## Try it

```
$ mkdir -p www/cgi-bin
$ echo '#!/bin/sh' > www/cgi-bin/shell
$ echo 'echo "content-type: text/plain"' >> www/cgi-bin/shell
$ echo 'echo ""' >> www/cgi-bin/shell
$ echo 'echo "Hello, World!"' >> www/cgi-bin/shell
$ echo 'echo "$QUERY_STRING"' >> www/cgi-bin/shell
$ docker run --name funcgi \
             --user 4000 \
             --security-opt=no-new-privileges \
             --cap-drop ALL \
             --read-only \
             --tmpfs /tmp \
             --volume "$(pwd)"/www:/var/www/localhost/htdocs \
             --publish 80:1337 tlcu/funcgi:base
$ curl localhost/cgi-bin/shell
Hello, World!
 curl localhost/cgi-bin/shell?hi!
Hello, World!
hi!
```

## Setup

The following commands will build and launch a container locally:

```
$ git clone https://github.com/tlcu/funcgi
$ cd funcgi
$ docker build <flavor> -t funcgi:<flavor>
$ ./run.sh <flavor>
```

Navigating to `http://localhost` should bring up the demo web page.
`$ curl localhost/cgi-bin/test` should get you a response from the
demo shell CGI script.

From here, you can edit and file to the `www` directory.
Executables should go in `www/cgi-bin/`, static content can
go anywhere else.

## How This Works

* [Alpine Linux] base
* [mini_httpd] webserver

The `docker run` commands try to constrain the CGI programs:
they are ran by an unprivileged user in a read-only filesystem.

## Inspired by / derived from / thanks to

* [dbohdan/jimsh-static]
* [dseg/docker-mini_httpd-cgi]
* [BCHS] stack
* [suckless philosophy]
* [OWASP]

## License

Code is [0BSD], content is [CC BY].

[0BSD]: https://tldrlegal.com/license/bsd-0-clause-license
[OWASP]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Docker_Security_Cheat_Sheet.md
[Alpine Linux]: https://alpinelinux.org/
[BCHS]: https://learnbchs.org/
[BusyBox]: https://www.busybox.net/
[CC BY]: https://tldrlegal.com/license/creative-commons-attribution-4.0-international-(cc-by-4)
[CGI]: https://tools.ietf.org/html/rfc3875
[dbohdan/jimsh-static]: https://github.com/dbohdan/jimsh-static
[dseg/docker-mini_httpd-cgi]: https://github.com/dseg/docker-mini_httpd-cgi
[forth]: https://en.wikipedia.org/wiki/Forth_(programming_language)
[guile]: https://www.gnu.org/software/guile/
[jim]: http://jim.tcl.tk/
[lua]: https://www.lua.org/
[mini_httpd]: https://www.acme.com/software/mini_httpd/
[perl]: https://www.perl.org/
[python]: https://www.python.org/
[ruby]: https://www.artima.com/intv/ruby.html
[suckless philosophy]: https://suckless.org/philosophy/
[tcl]: https://en.wikipedia.org/wiki/Tcl
