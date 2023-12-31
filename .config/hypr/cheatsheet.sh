#!/bin/bash

# Path to your image
IMAGE_PATH="/home/vedant/.config/hypr/my-cheatsheet.png"

# File to store the process ID
PID_FILE="/tmp/display_image_pid"

# Check if the PID file exists
if [ -f "$PID_FILE" ]; then
    # If the file exists, read the PID and kill the process
    PID=$(cat "$PID_FILE")
    kill "$PID"
    rm "$PID_FILE"
else
    # If the file doesn't exist, display the image in a floating window
    feh --scale-down --auto-zoom --geometry 711x661+100+100 "$IMAGE_PATH" &
    # Store the PID in the file
    echo $! > "$PID_FILE"
fi

