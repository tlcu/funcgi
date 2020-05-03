#!/usr/bin/env python3
import datetime
import pytz
import sys
import os

if os.environ.get('QUERY_STRING', False):
    tz = os.environ.get('QUERY_STRING')
elif len(sys.argv) >= 2:
    tz = sys.argv[1]
else:
    tz = 'UTC'

if os.environ.get('GATEWAY_INTERFACE', False):
    print('content-type: text/plain\n')

tzone = pytz.timezone(tz)
stamp = datetime.datetime.now().microsecond()
print(tzone.localize(stamp).isoformat())
