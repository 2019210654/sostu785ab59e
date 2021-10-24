#!/bin/bash
#
# Run runsql.sh from 1 to 22
#

results_dir=${1:-"/var/tmp/00"}

[[ -d $results_dir ]] || mkdir -p $results_dir

for i in $(ls -1 stub/*.sql) ; do
	echo ">>> Run $i ..."
	idx=$(basename $i)
	idx=${idx%.sql}
	logfile=$results_dir/testlog${idx}.md
	echo '```bash' > $logfile
	echo "oracle@FOO:queries\$ ./runsql.sh -v $i" >> $logfile
	./runsql.sh -v $i >> $logfile 2>&1
	echo '```' >> $logfile
	sleep 2
done
