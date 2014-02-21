#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 <VM name>"
	exit 1
fi

VM_NAME=$1

FILENAME="${VM_NAME}-`date +%s`.png"
VBoxManage controlvm ${VM_NAME} screenshotpng ${FILENAME}
chmod 644 ${FILENAME}
