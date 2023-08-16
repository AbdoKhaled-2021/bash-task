#!/bin/bash

# Define variables
remote_username="your_remote_username"
remote_ip="remote_server_ip"
remote_path="remote_path_to_store_files"

# Run commands and output to files
ps aux > process_info.txt
free -m > memory_usage.txt
df -h > disk_usage.txt

# Check if commands were successful
if [ $? -eq 0 ]; then
    echo "Commands were successful."
else
    echo "One or more commands failed."
    exit 1
fi

# Validate files exist
if [ -f process_info.txt ] && [ -f memory_usage.txt ] && [ -f disk_usage.txt ]; then
    echo "All required files exist."
else
    echo "One or more files are missing."
    exit 1
fi

# Compress files
tar -czvf system_info.tar.gz process_info.txt memory_usage.txt disk_usage.txt

# Check if compression was successful
if [ $? -eq 0 ]; then
    echo "Compression successful."
else
    echo "Compression failed."
    exit 1
fi

# Copy files using scp
scp system_info.tar.gz $remote_username@$remote_ip:~/$remote_path

# Check if copy was successful
if [ $? -eq 0 ]; then
    echo "Files copied successfully."
else
    echo "Files copying failed."
    exit 1
fi

echo "Process completed successfully."
