#!/bin/bash

# Get the current servo position
POSITION=$(curl -k -s -X 'GET' 'https://localhost:8000/servo/angle' -H 'accept: application/json' | jq '.servo_position')

# Increment position by 5
POSITION=$((POSITION + 5))

# Ensure position does not exceed 180
if [ $POSITION -gt 180 ]; then
    POSITION=180
fi

# Set the new servo position
curl -k -X 'POST' "https://localhost:8000/servo/angle?angle=$POSITION" -H 'accept: application/json' -d ''
echo "Servo angle incremented to $POSITION"

