#!/bin/bash
rm ctlout.json
touch ctlout.json
TIME=0
while :
do
        echo "Press CTRL+C to exit"
        auditctl -s > out
        LOST=`grep lost out | cut -d' ' -f2`
        BACKLOG=`grep -w backlog out | cut -d' ' -f2`
        echo "{\"lost\":"$LOST",\"backlog\":"$BACKLOG",\"time\":"$TIME"}" >> ctlout.json
        sleep 1
        TIME=$(( $TIME + 1 ))
done
rm out
