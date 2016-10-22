#!/bin/sh

pvcreate /dev/sdb
vgextend ubuntu-vg /dev/sdb
lvextend /dev/ubuntu-vg/root /dev/sdb
resize2fs /dev/ubuntu-vg/root
