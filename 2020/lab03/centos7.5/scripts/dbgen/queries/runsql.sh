#!/bin/bash
#
# Run 22 Query SQL files
#

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}

function usage
{
	echo "Usage: $1 [-v] [-t] <sql file>" >&2
}

g_user="C##huanli"
g_password="huanli"
g_dbinstance="ORCLCDB"

g_verbose=FALSE
g_trace=FALSE
while getopts ':vth' iopt; do
	case $iopt in
	v) g_verbose=TRUE ;;
	t) g_trace=TRUE ;;
	h) usage $0; exit 1 ;;
	:) echo "Option '-$OPTARG' wants an argument" >&2; exit 1 ;;
	'?') # '?' must be quoted here
	   echo "Option '-$OPTARG' not supported" >&2; exit 1 ;;
	esac
done
shift $((OPTIND - 1))
if (( $# != 1 )); then
	usage $0
	exit 1
fi

F_SQL=$TMPDIR/foo.sql
> $F_SQL
if [[ $g_verbose == "TRUE" ]]; then
	# To get 'Execution Plan, Predicate Information and Statistics'
	echo "set autotrace on;" >> $F_SQL
	echo "set timing on;"    >> $F_SQL
fi
if [[ $g_trace == "TRUE" ]]; then
	# SQL TRACE : tkprof <*huanli.trc> /var/tmp/a.out
	echo "ALTER SESSION SET sql_trace=TRUE;"                     >> $F_SQL
	echo "ALTER SESSION SET TRACEFILE_IDENTIFIER = 'HuanianLi';" >> $F_SQL
fi
cat $1 >> $F_SQL
if [[ $g_trace == "TRUE" ]]; then
	cat >> $F_SQL << EOF
ALTER SESSION SET sql_trace=FALSE;
SELECT value FROM v\$diag_info WHERE name = 'Default Trace File';
EOF
fi

cat -n $F_SQL
echo ">>> $*"
sqlplus "$g_user/$g_password@$g_dbinstance" < $F_SQL

exit 0
