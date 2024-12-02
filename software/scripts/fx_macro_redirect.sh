#!/bin/bash

# Define the log file
logfile="$HOME/.fx_macro_redirect.log"
logging_enabled=true # Default: logging enabled

# Default value for the --key parameter
key=""

# Parse the arguments
for arg in "$@"; do
    case $arg in
        --key=*)
            key="${arg#*=}" # Extract the value after the '=' sign
            ;;
        --no-log)
            logging_enabled=false # Disable logging if --no-log is passed
            ;;
    esac
done

# Logging function (logs only if logging is enabled)
log() {
    if [[ "$logging_enabled" == true ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$logfile"
    fi
}

# Check if the key parameter is provided
if [[ -n "$key" ]]; then
    log "The value of --key is: $key"

        # Handle specific key presses
    if [[ "$key" == "FX_F13" ]]; then
        log "Triggering toggle_audio_devices.sh for $key"
        toggle_audio_devices.sh >> "$logfile" 2>&1
    elif [[ "$key" == "FX_F15" ]]; then
        log "Triggering increment_by_5.sh for $key"
        increment_by_5.sh >> "$logfile" 2>&1
    elif [[ "$key" == "FX_F18" ]]; then
        log "Triggering decrement_by_5.sh for $key"
        decrement_by_5.sh >> "$logfile" 2>&1
    else
        log "No action defined for key $key"
    fi
else
    log "Error: --key parameter is required"
    exit 1
fi

