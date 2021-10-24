#!/bin/bash

user='C##huanli'
password='huanli'
database='ORCLCDB'

if [[ -f $1 ]]; then
	sqlplus "$user/$password@$database" < $1
else
	sqlplus "$user/$password@$database" <<< "$@"
fi
exit $?
