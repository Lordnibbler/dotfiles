#!/bin/bash

# Usage
# ssh ben@192.168.50.45
# sudo -i
# cd /volume1
# ./backup.sh

# Define log directory
LOG_DIR="/volume1/backup_logs"
mkdir -p "$LOG_DIR"  # Ensure the log directory exists

# Define log file paths
LOG_BEN="$LOG_DIR/rsync-ben.txt"
LOG_SHARED="$LOG_DIR/rsync-shared.txt"
LOG_KAREN="$LOG_DIR/rsync-karen.txt"

# Define source directories
DIR_SRC_BEN="/volume1/Ben"
DIR_SRC_SHARED="/volume1/Shared"
DIR_SRC_KAREN="/volume1/Karen"

# Define destination directories
DIR_DEST_BEN="/volumeUSB1/usbshare/Ben"
DIR_DEST_SHARED="/volumeUSB1/usbshare/Shared"
DIR_DEST_KAREN="/volumeUSB1/usbshare/Karen"

echo "Starting Backup. There will be a delay while rsync traverses all directories, please wait..."

# Backup /volume1/Ben folder
# echo "Starting Backup of $DIR_SRC_BEN to $DIR_DEST_BEN: $(date)" | tee -a "$LOG_BEN"
# rsync -ah --delete --info=progress2 --no-inc-recursive $DIR_SRC_BEN $DIR_DEST_BEN | tee -a "$LOG_BEN"
# echo "$DIR_SRC_BEN Backup Completed: $(date)" | tee -a "$LOG_BEN"
# echo "" | tee -a "$LOG_BEN"

# Backup /volume1/Shared folder
echo "Starting Backup of $DIR_SRC_SHARED to $DIR_DEST_SHARED: $(date)" | tee -a "$LOG_SHARED"
rsync -ah --delete --info=progress2 --no-inc-recursive $DIR_SRC_SHARED $DIR_DEST_SHARED | tee -a "$LOG_SHARED"
echo "$DIR_SRC_SHARED Backup Completed: $(date)" | tee -a "$LOG_SHARED"
echo "" | tee -a "$LOG_SHARED"

# Backup /volume1/Karen folder
echo "Starting Backup of $DIR_SRC_KAREN to $DIR_DEST_KAREN: $(date)" | tee -a "$LOG_KAREN"
rsync -ah --delete --info=progress2 --no-inc-recursive $DIR_SRC_KAREN $DIR_DEST_KAREN | tee -a "$LOG_KAREN"
echo "$DIR_SRC_KAREN Backup Completed: $(date)" | tee -a "$LOG_KAREN"
echo "" | tee -a "$LOG_KAREN"

echo "All backups completed successfully."