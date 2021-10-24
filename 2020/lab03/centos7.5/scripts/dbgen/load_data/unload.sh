#!/bin/bash
#
# Clean up all tables in database 'ORCLCDB' by default
#

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}

user=${1:-"C##huanli"}
password=${2:-"huanli"}
database=${3:-"ORCLCDB"}

sqlplus "$user/$password@$database" < $CDIR/sql/cleanup_all_data.sql
