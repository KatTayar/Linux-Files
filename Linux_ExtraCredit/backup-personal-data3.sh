!/bin/bash

# Define the source and destination directories
source_dir="/home/username/data"
backup_dir="/home/username/backups"

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory '$source_dir' does not exist."
  exit 1
fi

# Create the destination directory if it doesn't exist
if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi

# Check if the backup file already exists
if [ -e "$backup_file" ]; then
  echo "Backup file '$backup_file' already exists."
  exit 1
fi

# Define the backup file name with the current date
backup_filename="data-backup-$(date +'%Y-%m-%d').tar.gz"
backup_file="$backup_dir/$backup_filename"


# Use rsync to create the backup = copies both permisions and set up of original directory 
rsync -avz "$source_dir/" "$backup_dir/"

# Create a tar.gz archive of the backup directory
tar czf "$backup_file" -C "$backup_dir" .

# Calculate and store the MD5 checksum of the backup file
md5sum "$backup_file" >> "$backup_dir/checksums.txt"

echo "Backup of $source_dir successfully created at $backup_file"
