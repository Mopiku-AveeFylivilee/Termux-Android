#!/usr/bin/bash
clear

# Update and install needed packages
echo -e "\e[0;32mInstalling some pakages...\e[0m"
pkg update && pkg upgrade -y
pkg i tur-repo -y
pkg i x11-repo -y
pkg i termux-x11-nightly -y
pkg i pulseaudio -y
pkg i wget -y
pkg i git -y
pkg i dialog -y
pkg i fastfetch -y
pkg i vulkan-loader -y
pkg i mesa -y
pkg i virglrenderer-android -y
pkg i xfce4 -y
pkg i vim -y

# Setup storage.
echo #
echo -e "\e[0;33mTHIS IS OPTIONAL.\e[0m"
echo -e "\e[0;32mIf you want to link your Android folder, please give the app permission to access your file.\e[0m"
echo -e "\e[0;32mYou can setup it anytime with executing: 'termux-setup-storage'.\e[0m"
echo #
read -p "Link your Android storage? (y/N): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo #
    echo -e "\e[0;32mLinking...\e[0m"
    termux-setup-storage
fi

# Modify .bashrc and create .bash_profile
echo #
echo 'Modifying file .bashrc and creating .bash_profile...'
# .bashrc
cat << 'EOF' >> ~/.bashrc
# Script shortcuts.
alias desktop="~/startxfce4_termux.sh &"
alias xorg11="~/startx11.sh &"

# Command shortcuts.
alias stolist="du -ah --max-depth=1"
alias killx11='echo "Killing Xorg11..." && kill -9 $(pgrep -f "termux.x11") 2>/dev/null'
EOF
# .bash_profile
cat << 'EOF' >> ~/.bash_profile
# Login desktop confirmation.
echo #
read -p "Login desktop? (y/N): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    clear
    echo "Starting XFCE4..."
    ~/startxfce4_termux.sh
fi
clear

# Calling .bashrc if the file exis.
if [ -f ~/.bashrc ]
then
    source ~/.bashrc
fi
EOF

# Make two launcher scripts.
echo "Making two launcher scripts..."
# startxfce4_termux.sh
cat << 'EOF' >> ~/startxfce4_termux.sh
#!/data/data/com.termux/files/usr/bin/bash
# Srcipt by: DroidMaster. Modified by:Mopiku.

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
EOF
# startx11.sh
cat << 'EOF' >> ~/startx11.sh
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

# Export display with GPU acceleration on port: 0 and launch DBus
export GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 DISPLAY=:0 && dbus-launch &

# Run window manager
xfwm4 &

# Auto start app
thunar &
xfce4-terminal &

exit 0
EOF

# Give the launcher scripts permission to execute.
echo #
echo "Giving two launcher scripts permission to execute..."
cd ~ && chmod +x startxfce4_termux.sh startx11.sh
rm ~/termux_setup.sh

echo #
echo -e "\e[0;32mTermux setup was complited!\e[0m"
echo -e "\e[0;32mPlease loging-out and loging-in to apply the change.\e[0m"
echo -e "\e[0;32m(Press CTRL + D)\e[0m"

exit 0
