#!/bin/bash

FILE=$(readlink -f $BASH_SOURCE)
NAME=$(basename $FILE)
CDIR=$(dirname $FILE)
TMPDIR=${TMPDIR:-"/tmp"}


RPM_ORCLDB_PRE=oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
RPM_ORCLDB=oracle-database-ee-19c-1.0-1.x86_64.rpm
TGZ_RLWRAP=rlwrap-0.43.tar.gz
function pre_install_oracle
{
	typeset opkg_dir=$1
	yum -y localinstall $opkg_dir/$RPM_ORCLDB_PRE
	return $?
}

function install_oracle
{

	typeset opkg_dir=$1
	yum -y localinstall $opkg_dir/$RPM_ORCLDB
	return $?
}

function install_rlwrap
{
	typeset opkg_dir=$1
	yum -y install readline-devel

	pushd $(pwd -P) > /dev/null 2>&1
	cd $opkg_dir
	tar zxf $TGZ_RLWRAP && cd ${TGZ_RLWRAP%.tar.gz}
	./configure || return 1
	make || return 1
	make install || return 1
	popd > /dev/null 2>&1
	return 0
}

function main
{
	typeset opkg_dir=$1
	install_rlwrap $opkg_dir || return 1
	pre_install_oracle $opkg_dir || return 1
	install_oracle $opkg_dir || return 1
	return 0
}

ORACLE_PKG_DIR=${1?"*** pkg dir to install Oracle"}
main $ORACLE_PKG_DIR
exit $?
