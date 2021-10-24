#!/bin/bash
#
# Start Oracle 19c if it is down
#

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}

lsnrctl start
sqlplus / as sysdba <<< "startup"
sleep 30
lsnrctl status
exit $?
