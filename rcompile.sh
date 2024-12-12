#!/bin/bash

set -e

if [ $# -ne 2 ];
then
	echo "Usage: ./rcompile.sh <machine_name> <remote kernel dir>"
	exit
fi

machine=$1
kdir=$2

git diff > current.diff
scp current.diff root@$machine:$kdir
ssh $machine -- "cd $kdir; patch -p1 < current.diff; make -j64 -s --directory=$kdir"

