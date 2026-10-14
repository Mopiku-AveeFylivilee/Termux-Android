#!/data/data/com.termux/files/usr/bin/bash
# Script by: DroidMaster. Modified by: Mopiku.

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Starting graphical server (Fulkan)
virgl_test_server_android &

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

# Wait a bit until termux-x11 gets started.
sleep 1

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

# Set audio server
export 'PULSE_SERVER=127.0.0.1'

# Run XFCE4 Desktop
env DISPLAY=:0 GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 dbus-launch --exit-with-session xfce4-session > /dev/null 2>&1

# If user logout, kill all server and Termux:X11
# Stop the PulseAudio and graphical server on Termux
kill -9 $(pgrep -f "termux.x11") 2>/dev/null
pkill -f termux-x11
killall -9 virgl_test_server 2>/dev/null
pkill virgl_test_server
pulseaudio --kill 2>/dev/null
pkill pulseaudio

# Force-close Termux-X11 application on Android
am force-stop com.termux.x11 > /dev/null 2>&1
clear

exit 0
