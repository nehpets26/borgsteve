#!/bin/bash

# Arguments
DB_NAME="employees"
DB_USER="root"
OUTPUT_PATH="/var/backups/dbbackups/"

# Timestamp and filenames
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$OUTPUT_PATH/backup_$TIMESTAMP.log"
BACKUP_FILE="$OUTPUT_PATH/${DB_NAME}_backup_$TIMESTAMP.sql.gz"

# Usage check
if [[ -z "$DB_NAME" || -z "$DB_USER" || -z "$OUTPUT_PATH" ]]; then
    echo "Usage: $0 <db_name> <mysql_user> <output_path>"
    exit 1
fi

# Ensure output directory exists
mkdir -p "$OUTPUT_PATH"

# Log and Backup
{
    echo "[$(date)] Starting backup for DB: $DB_NAME"

    # Run mysqldump and gzip the result
    if mysqldump -u "$DB_USER" "$DB_NAME" | gzip > "$BACKUP_FILE"; then
        echo "[$(date)] Backup successful: $BACKUP_FILE"
    else
        echo "[$(date)] Backup FAILED"
        exit 1
    fi
} >> "$LOG_FILE" 2>&1
