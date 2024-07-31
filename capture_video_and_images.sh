#!/bin/bash

# Define the output paths and filenames
VIDEO_OUTPUT="udp://127.0.0.1:5000"
IMAGE_OUTPUT="/home/ashleysagar/MA_FinalProject/capturedImages/image%00009.png"

# Run rpicam to capture video to a local UDP port in the background
rpicam-vid --inline -o "$VIDEO_OUTPUT" -n --width 1024 --height 600 --timeout 3600000 --vflip 1 &
VID_PID=$!

# Run rpicam to capture still images at intervals
while true; do
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    OUTPUT_FILE="${IMAGE_OUTPUT%image*}image_${TIMESTAMP}.png"

    # Capture a still image
    rpicam-still --encoding png --timeout 10 --vflip 1 -o "$OUTPUT_FILE"

    # Wait for a specified interval before capturing the next image (e.g., 60 seconds)
    sleep 60
done &

# Wait for the video capture process to complete
wait $VID_PID
