#!/usr/bin/bash

clear
echo "Starting Termux:X11 on port: 0"

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 &
sleep 1

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
sleep 1

# Set audio server
export 'PULSE_SERVER=127.0.0.1'

# Start graphical server
virgl_test_server_android &

# Export display with GPU acceleration on port: 0
export GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 DISPLAY=:0 && dbus-launch &

# Run window manager
xfwm4 &

# Auto start app
thunar &

exit 0
