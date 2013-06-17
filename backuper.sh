#!/bin/bash

BASE_DIR="./backups/"

BACKUP_DIR=$BASE_DIR$(date +"%y%m%d%H%M%S")

DB="stdb"

echo Start dump $DB to $BACKUP_DIR

# check base backup dir on presence
if [ ! -d "$BASE_DIR" ]; then
	mkdir $BASE_DIR
fi

# check backup dir on presence
if [ ! -d "$BACKUP_DIR" ];then
	mkdir $BACKUP_DIR
	echo Create $BACKUP_DIR successfully
else
	echo "Create backup failed (exist). Exit"
	exit 1
fi

mongodump -d $DB -o $BACKUP_DIR

echo OK