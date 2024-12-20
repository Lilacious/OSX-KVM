#!/usr/bin/env bash
MYTMPDIR="$(mktemp -d)"
# Make sure to be in right directory
cd $(dirname "$0")

# Replace CHANGEME with repo path
sed "s|CHANGEME|$PWD|g" macOS-on-NixOS.xml > $MYTMPDIR/macOS.xml

# Validate and create VM using macOS.xml
virt-xml-validate $MYTMPDIR/macOS.xml
if [[ $? -eq 0 ]]
then
	virsh --connect qemu:///system define $MYTMPDIR/macOS.xml
fi

# Delete tmp dir on exit
trap 'rm -rf -- "$MYTMPDIR"' EXIT
