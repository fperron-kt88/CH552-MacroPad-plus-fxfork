#!/bin/bash

# Define sink and source names
LAPDOCK_SINK="alsa_output.usb-DisplayLink_LAPDOCK_U3D2338811954-02.iec958-stereo"
LAPDOCK_SOURCE="alsa_input.usb-DisplayLink_LAPDOCK_U3D2338811954-02.iec958-stereo"

SPEAKER_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink"
MIC_SOURCE="alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source"

# Get the current default sink and source
CURRENT_SINK=$(pactl get-default-sink)
CURRENT_SOURCE=$(pactl get-default-source)

# Function to switch the audio sink
switch_sink() {
    local new_sink=$1
    echo "Switching sink to: $new_sink"
    pactl set-default-sink "$new_sink"
    pactl list sink-inputs short | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$new_sink"
}

# Function to switch the audio source
switch_source() {
    local new_source=$1
    echo "Switching source to: $new_source"
    pactl set-default-source "$new_source"
    pactl list source-outputs short | awk '{print $1}' | xargs -I{} pactl move-source-output {} "$new_source"
}

# Toggle between LAPDOCK and SPEAKER setup
if [ "$CURRENT_SINK" = "$LAPDOCK_SINK" ]; then
    # Switch to SPEAKER sink and MIC source
    switch_sink "$SPEAKER_SINK"
    switch_source "$MIC_SOURCE"
else
    # Switch to LAPDOCK sink and source
    switch_sink "$LAPDOCK_SINK"
    switch_source "$LAPDOCK_SOURCE"
fi
