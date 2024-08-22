



#!/bin/bash

# Directory to store photos
TARGET_DIR=~/Documents/Dev/openFrameworks/apps/myApps/images/bin/data

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Interval between photos (in seconds)
INTERVAL=0.5

# Counter for filenames
COUNTER=1


# function to delete photos older than 3 mins
cleanup_old_photos(){
    find "$TARGET_DIR" -type f -name "*.jpg" -mmin +3 -exec rm {} \;
}


# Loop indefinitely
while true; do
    # Define filename with a counter and timestamp
    FILENAME=$(printf "photo_%08d_%s.jpg" "$COUNTER" "$(date +%Y%m%d_%H%M%S)")

    # delete the old photo is it eexists
     if [ -f "$TARGET_DIR/$CURRENT_FILENAME" ]; then
        rm "$TARGET_DIR/$CURRENT_FILENAME"
    fi
    # Take a photo and save it to the target directory
    fswebcam -d /dev/video0 -r 1280x720 --jpeg 1 -D 1 "$TARGET_DIR/$FILENAME"
    
    # Increment the counter
    COUNTER=$((COUNTER + 1))


    # cleanup old images
    cleanup_old_photos

    
    # Wait for the specified interval
    sleep "$INTERVAL"
done


