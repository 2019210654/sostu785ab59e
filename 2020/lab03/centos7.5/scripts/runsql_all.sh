#/bin/bash
FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}

function get_unixtime
{
	python3 -c "import time; print('%.0f' % time.time())"
}

function get_datetime
{
	date +"%Y%m%d%H%M%S"
}

function get_interval
{
	typeset a=$1
	typeset b=$2
	python3 -c "print('%d' % ($b - $a))"
}

results_dir=${1?"*** What dir to save results? e.g. /var/tmp/01/t1"}
[[ ! -d $results_dir ]] && mkdir -p $results_dir

export PS4='>>> '
echo "ID:StartTime:EndTime:StartUnixTime:EndUnixTime:Cost"
total_start_dt=$(get_datetime)
total_start_ts=$(get_unixtime)
for i in $(ls -1 dbgen/queries/stub/*.sql); do
	set -x
	idx=$(basename $i | awk -F'.' '{print $1}')
	fmd=$results_dir/testlog${idx}.md
	echo '```' > $fmd
	echo "# Results of running $(basename $i)" >> $fmd
	start_dt=$(get_datetime)
	start_ts=$(get_unixtime)
	dbgen/queries/runsql.sh -v $i >> $fmd 2>&1
	#sleep 2
	end_ts=$(get_unixtime)
	end_dt=$(get_datetime)
	intv=$(get_interval $start_ts $end_ts)
	echo "${idx}.sql:$start_dt:$end_dt:$start_ts:$end_ts:$intv"
	echo "# ${idx}.sql:$start_dt:$end_dt:$start_ts:$end_ts:$intv #" >> $fmd
	echo '```' >> $fmd
done

total_end_ts=$(get_unixtime)
total_end_dt=$(get_datetime)
total_intv=$(get_interval $total_start_ts $total_end_ts)
echo "TOTAL#:$total_start_dt:$total_end_dt:$total_start_ts:$total_end_ts:$total_intv"
