#!/bin/bash
#
# Load data to Oracle database via ctl files
#

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}

function print   { printf -- "$*\n"; }

function _isatty
{
	typeset -l isatty=$ISATTY
	[[ $isatty == "yes" ]] && return 0
	[[ $isatty ==  "no" ]] && return 1
	[[ -t 1 && -t 2 ]] && return 0 || return 1
}

function str2gray    { _isatty && print "\033[1;30m$@\033[m" || print "$@"; }
function str2red     { _isatty && print "\033[1;31m$@\033[m" || print "$@"; }
function str2green   { _isatty && print "\033[1;32m$@\033[m" || print "$@"; }
function str2yellow  { _isatty && print "\033[1;33m$@\033[m" || print "$@"; }
function str2blue    { _isatty && print "\033[1;34m$@\033[m" || print "$@"; }
function str2magenta { _isatty && print "\033[1;35m$@\033[m" || print "$@"; }
function str2cyan    { _isatty && print "\033[1;36m$@\033[m" || print "$@"; }
function str2white   { _isatty && print "\033[1;37m$@\033[m" || print "$@"; }

function run_cmd
{
	str2cyan "$(id -un)\$ $*"
	eval "$*"
	typeset -i rc=$?
	echo
	return $rc
}

function get_datetime
{
	date +"%Y%m%d%H%M%S"
}

user=${1:-"C##huanli"}
password=${2:-"huanli"}
shift 2
ctlfiles="$@"

default_ctlfiles=""
default_ctlfiles+=" customer.ctl"
default_ctlfiles+=" lineitem.ctl"
default_ctlfiles+=" nation.ctl"
default_ctlfiles+=" orders.ctl"
default_ctlfiles+=" part.ctl"
default_ctlfiles+=" partsupp.ctl"
default_ctlfiles+=" region.ctl"
default_ctlfiles+=" supplier.ctl"
[[ -z $ctlfiles ]] && ctlfiles=$default_ctlfiles

dt_start=$(get_datetime)
for ctlfile in $ctlfiles; do
	str2yellow ">>> Now start to load $CDIR/ctl/$ctlfile ..."
	sleep 10
	run_cmd "sqlldr userid='$user/$password' control = $CDIR/ctl/$ctlfile"
done
dt_end=$(get_datetime)

echo "Start: $dt_start"
echo "End  : $dt_end"
