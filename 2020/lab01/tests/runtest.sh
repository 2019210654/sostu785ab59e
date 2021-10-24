#!/bin/bash

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)

function run_cmd
{
	echo '```'
	echo "$(id -un)@$(hostname)\$ $*"
	eval "$*"
	typeset -i rc=$?
	echo '```'
	return $rc
}

outfile=${1:-"out.md"}
> $outfile
run_cmd ../utils/recm -u A -m c ../data/matrix.txt >> $outfile
run_cmd ../utils/recm -u A -m e ../data/matrix.txt >> $outfile
run_cmd ../utils/recm -u B -m b ../data/matrix.txt >> $outfile
run_cmd ../utils/recm -v ../data/matrix.txt >> $outfile
cat -n $outfile
exit 0
