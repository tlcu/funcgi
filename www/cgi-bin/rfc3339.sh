#!/bin/sh
# Unites RFC3339, RFC3875, RFC8536, and IEEE 1003 (POSIX).
# An available TZDATA timezone database makes this program much more useful:
# allowing for input like "America/Los_Angeles" instead of "PST8PDT".
# Do we have command line or GET arguments?
if test -z "$1"
  then TZ='UTC'
elif test "$QUERY_STRING" != ''
then
  TZ="$QUERY_STRING"
else TZ="$1"
fi
# Are we running CGI?
if test "$GATEWAY_INTERFACE"
then
 echo "content-type: text/plain"
 echo ""
fi

# The sed command corrects timezone offset formatting.
echo "$(TZ=$1 date '+%Y-%m-%dT%H:%M:%S%z' | sed 's@^.\{22\}@&:@')"
gdate --help
