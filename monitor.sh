#!/bin/bash

FROM="no-reply@idlast.com"
TO="a.sysoff@gmail.com"

echo `date`

echo "Check ST status"
ST=$(/home/ubuntu/shutter_tracker/rel/shutter_tracker/bin/shutter_tracker ping)
echo "ST responed: $ST"
if [[ "$ST" != "pong" ]]; then
    echo "ST response not equal -pong-. Sending mail."
    (echo "Subject: [warn] ST unavailable";echo "From: $FROM";echo "To: $TO";echo;echo "Response details:";echo $ST) | /usr/sbin/sendmail -t -f $FROM
else
    echo "ST status OK"
fi

echo
echo "Check mongodb status"
MONGO_SERVER_STATUS=$(mongo --eval 's = db.serverStatus();printjson(s);')
echo "Mongodb responed: $MONGO_SERVER_STATUS"
MONGO_SERVER_STATUS_OK=$(echo $MONGO_SERVER_STATUS | grep '"ok" : 1')

if [[ "$MONGO_SERVER_STATUS_OK" == "" ]]; then
    echo "MongoDB response is not contain {ok:1}. Sending mail"
    (echo "Subject: [warn] MONGO unavailable";echo "From: $FROM";echo "To: $TO";echo;echo "db.serverStatus():";echo $MONGO_SERVER_STATUS) | /usr/sbin/sendmail -t -f $FROM
else
    echo "MongoDB status OK"
fi

echo
echo "Check rails ui status"
RAILS_UI_HEADERS=$(curl -s -D - "http://idlast.microstock.ru" -o /dev/null)
RAILS_UI_STATUS=$(echo $RAILS_UI_HEADERS | grep '200 OK')
echo "Rails ui response headers: $RAILS_UI_HEADERS"
if [[ "$RAILS_UI_STATUS" == "" ]]; then
    echo "Rails ui root page respond not 200 OK. Send email"
    (echo "Subject: [warn] Rails ui unavailable";echo "From: $FROM";echo "To: $TO";echo;echo "Rails ui root page response headers";echo $RAILS_UI_HEADERS) | /usr/sbin/sendmail -t -f $FROM
else
    echo "Rails ui status OK"
fi
echo
echo "Sleep";echo

exit 0