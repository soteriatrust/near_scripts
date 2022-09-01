#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=~/.near
BACKUPDIR=~/backups/near_${DATE}

mkdir $BACKUPDIR

sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts

    cp -rf $DATADIR/mainnet/data/ ${BACKUPDIR}/

    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    # Example
    curl https://hc-ping.com/3d140899-6c59-4971-be3b-2904d7c48c92

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts
