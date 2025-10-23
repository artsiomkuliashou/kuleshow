#!/bin/bash

# Add timestamp to all log files with country names
# Expected format: filename_{timestamp}.log
# For all files with .log extension, add timestamp before the extension

# Check if there are any .log files in the directory
if [ $(ls *.log 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Error: No .log files found in current directory"
    exit 1
fi

# Get current timestamp in format: YYYYMMDD_HHMMSS
timestamp=$(date +"%Y%m%d_%H%M%S")

# Process all .log files in current directory
for file in *.log; do
    # Check if file exists and is a regular file (not directory)
    if [ -f "$file" ]; then
        # Check if file is readable
        if [ ! -r "$file" ]; then
            echo "Warning: File $file is not readable. Skipping."
            continue
        fi        
        
        # Extract filename without extension
        filename_without_ext="${file%.log}"
        
        # Create new filename with timestamp
        new_filename="${filename_without_ext}_${timestamp}.log"
        
        # Check if new filename already exists
        if [ -e "$new_filename" ]; then
            echo "Error: Target file $new_filename already exists. Skipping $file"
            continue
        fi
        
        # Rename the file and check if successful
        if mv "$file" "$new_filename"; then
            echo "Success: Renamed: $file -> $new_filename"
        else
            echo "Error: Failed to rename $file"
        fi
    fi
done

echo "File renaming process completed"