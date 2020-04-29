#!/bin/sh
docker run --user 4000 \
           --security-opt=no-new-privileges \
           --cap-drop ALL \
           --read-only \
           --tmpfs /tmp \
           --volume "$(pwd)"/www:/var/www/localhost/htdocs \
           --publish 80:1337 funcgi:"$1"
