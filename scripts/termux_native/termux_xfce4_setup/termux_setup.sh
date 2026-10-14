#!/usr/bin/bash
clear

# Update and installing needed packages
echo -e "\e[0;32mInstalling some pakages...\e[0m"
pkg update && pkg upgrade -y
pkg i tur-repo -y
pkg i x11-repo -y
pkg i termux-x11-nightly -y
pkg i pulseaudio -y
pkg i wget -y
pkg i git -y
pkg i mpv -y
pkg i vlc -y
pkg i gwenview -y
pkg i starship -y
pkg i dialog -y
pkg i fastfetch -y
pkg i vulkan-loader -y
pkg i mesa -y
pkg i virglrenderer-android -y
pkg i xfce4 -y
pkg i vim -y

# Setup storage.
echo #
echo -e "\e[0;32mIf you want to link your Android folder, please give the app permission to access your file.\e[0m"
echo -e "\e[0;32mYou can setup it again whatever you want with executing: 'termux-setup-storage'.\e[0m"
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
eval "$(starship init bash)"

# Script shortcuts.
alias desktop="~/startxfce4_termux.sh &"
alias archkde="~/startkde_arch.sh &"
alias xorg11="~/startx11.sh &"

# Command shortcuts.
alias stolist="du -ah --max-depth=1"
alias killx11='echo "Killing Xorg11..." && kill -9 $(pgrep -f "termux.x11") 2>/dev/null'
EOF
# .bash_profile
cat << 'EOF' >> ~/.bash_profile
# Startup menu.
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

# Give the scripts permission to execute.
echo #
echo "Giving the scripts permission to execute..."
cd ~ && chmod +x startxfce4_termux.sh boot_menu.sh startx11.sh
rm ~/termux_setup.sh

echo #
echo -e "\e[0;32mTermux setup was complited!\e[0m"
echo -e "\e[0;32mPlease loging-out and loging-in to apply the change.\e[0m"
echo -e "\e[0;32m(Press CTRL + D)\e[0m"

exit 0
