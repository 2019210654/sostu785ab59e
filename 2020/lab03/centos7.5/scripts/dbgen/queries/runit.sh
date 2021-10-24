#!/bin/bash
#
# Create 22 Query SQL files and save to $TMPDIR/stub
#
# XXX: The 22 SQL files created by qgen have syntax issues, you have to update
#      them to make them work well!
#

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}

F_QGEN=$CDIR/../qgen
F_DISTS=$CDIR/../dists.dss

[[ ! -f dists.dss ]] && cp $F_DISTS dists.dss # setup
for (( i = 1; i <= 22; i++ )); do
	idx=$(printf "%02d" $i)
	[[ ! -d $TMPDIR/stub ]] && mkdir $TMPDIR/stub
	f_dst=$TMPDIR/stub/${idx}.sql
	echo ">>> Now create ${i}.sql ..."
	echo "-- TPC-H/TPC-R Pricing Summary Report Query (Q$i)" > $f_dst
	$F_QGEN -d $i >> $f_dst
	dos2unix $f_dst > /dev/null 2>&1 &
done
exit 0
