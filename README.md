# funcgi

Simple web programming.

![](https://upload.wikimedia.org/wikipedia/en/c/cd/CGIlogo.gif)

Frustrated with modern web development worst practices?

Sick of Evil Corp.™ 'services'?

Interested in scaling _down_ to a personal, hackable web?

Have fun with [CGI]!

## Flavors

A number of programming environments are ready to go:

| Flavor   | Description                                   | Size (MB) |
| ---------| --------------------------------------------- | --------- |
| base     | barebones [BusyBox] environment               | 5.73      |
| [Forth]  | _the_ stack based programming language        | 8.36      |
| [Guile]  | scheme dialect / GNU extension language       | 18.9      |
| [Jim]    | small-footprint yet full-featured Tcl dialect | 10.1      |
| [Lua]    | lightweight, embeddable scripting language    | 6.09      |
| [OCaml]  | an industrial strength programming language   | 202       |
| [Perl]   | 25,000 extensions on CPAN                     | 39.9      |
| [Python] | popular and easy-to-learn                     | 58.6      |
| [Ruby]   | 'Ruby is designed to make programmers happy'  | 24.3      |
| [Tcl]    | Tool Command Language, batteries included     | 20.6      |

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
[Forth]: https://en.wikipedia.org/wiki/Forth_(programming_language)
[Guile]: https://www.gnu.org/software/guile/
[Jim]: http://jim.tcl.tk/
[Lua]: https://www.lua.org/
[mini_httpd]: https://www.acme.com/software/mini_httpd/
[OCaml]: https://ocaml.org/
[Perl]: https://www.perl.org/
[Python]: https://www.python.org/
[Ruby]: https://www.artima.com/intv/ruby.html
[suckless philosophy]: https://suckless.org/philosophy/
[Tcl]: https://en.wikipedia.org/wiki/Tcl
