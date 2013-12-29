#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 <VM name>"
	exit 1
fi

VM_NAME=$1

VBoxManage unregistervm ${VM_NAME} --delete
