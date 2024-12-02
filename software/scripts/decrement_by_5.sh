#!/bin/bash

# Get the current servo position
POSITION=$(curl -k -s -X 'GET' 'https://localhost:8000/servo/angle' -H 'accept: application/json' | jq '.servo_position')

# Decrement position by 5
POSITION=$((POSITION - 5))

# Ensure position does not go below 0
if [ $POSITION -lt 0 ]; then
    POSITION=0
fi

# Set the new servo position
curl -k -X 'POST' "https://localhost:8000/servo/angle?angle=$POSITION" -H 'accept: application/json' -d ''
echo "Servo angle decremented to $POSITION"

