#!/data/data/com.termux/files/usr/bin/bash
clear

# Update and install needed packages
# --- safer shell options (no -e so we can handle errors) ---
set -u
trap 'echo "Script terminated unexpectedly"; exit 1' ERR

# Helper: install with retries
install_with_retries() {
  local pkg="$1"
  local max_retries="${2:-3}"
  local attempt=1
  local sleep_secs=2

  while [ $attempt -le $max_retries ]; do
    echo -e "\e[0;32mInstalling: $pkg (attempt $attempt/$max_retries)\e[0m"
    if pkg install -y "$pkg"; then
      echo -e "\e[0;32mInstalled: $pkg\e[0m"
      return 0
    else
      echo -e "\e[0;33mFailed to install: $pkg (attempt $attempt)\e[0m"
      # try updating package lists on first failure
      if [ $attempt -eq 1 ]; then
        echo -e "\e[0;33mRunning 'pkg update' and retrying...\e[0m"
        pkg update -y || true
      fi
      sleep $sleep_secs
      sleep_secs=$((sleep_secs * 2))
      attempt=$((attempt + 1))
    fi
  done

  # If we reach here, all attempts failed
  echo "$pkg" >> ~/termux_install_failed.txt
  return 1
}

# Update once first (best-effort)
echo -e "\e[0;32mUpdating package lists...\e[0m"
pkg update && pkg upgrade -y

# Packages to install (one by one)
PACKAGES=(
  tur-repo
  x11-repo
  termux-x11-nightly
  pulseaudio
  wget
  git
  dialog
  vlc-qt
  firefox
  xfce4-taskmanager
  vim
  vulkan-loader
  mesa
  virglrenderer-android
)

echo -e "\e[0;32mInstalling required packages...\e[0m"
for p in "${PACKAGES[@]}"; do
  install_with_retries "$p" 3
done

if [ -f ~/termux_install_failed.txt ]; then
  echo
  echo -e "\e[0;31mSome packages failed to install:\e[0m"
  cat ~/termux_install_failed.txt
  echo -e "\e[0;33mYou can try to install the packages manually with 'pkg i packages_name'.\e[0m"
  echo -e "\e[0;31mStop the script because some packages fails to install.\e[0m"
  echo "Rerun the script with executing: ./termux_setup.sh"
  rm -rf ~/termux_install_failed.txt
  exit 1
fi

# Make .scripts directory in user's home directory
mkdir -p ~/.scripts/

# Desktop environment selection
show_menu() {
    CHOICE=$(dialog --clear \
                --title "SELECT YOUR DESKTOP ENVIRONMENT" \
                --no-cancel \
                --menu "It's touch screen, or you can use arrow bottons on your external key bar to select. Enter to confirm." \
                11 45 2 \
                1 "XFCE4" \
                2 "KDE Plasma" \
                --stdout)

    case $CHOICE in
        1)
            clear
            PACKAGES=(
              xfce4
            )
            script1="https://raw.githubusercontent.com/MopikuAveely/Termux-Android/refs/heads/main/scripts/Termux_setup/startxfce4_termux.sh"
            script2="startxfce4_termux.sh"
            ln -sf ~/.scripts/startxfce4_termux.sh ~/.D
            ;;
        2)
            clear
            PACKAGES=(
              plasma-desktop
              dolphin
              konsole
              gwenview
              ark
            )
            script1="https://raw.githubusercontent.com/MopikuAveely/Termux-Android/refs/heads/main/scripts/Termux_setup/startkde_termux.sh"
            script2="startkde_termux.sh"
            ln -sf ~/.scripts/startkde_termux.sh ~/.D
            ;;
    esac
}

show_menu

echo -e "\e[0;32mInstalling desktop environment...\e[0m"
for p in "${PACKAGES[@]}"; do
  install_with_retries "$p" 3
done

if [ -f ~/termux_install_failed.txt ]; then
  echo
  echo -e "\e[0;31mSome packages failed to install:\e[0m"
  cat ~/termux_install_failed.txt
  echo -e "\e[0;33mYou can try to install the packages manually with 'pkg i packages_name'.\e[0m"
  echo -e "\e[0;31mStop the script because some packages fails to install.\e[0m"
  echo "Rerun the script with executing: ./termux_setup.sh"
  rm -rf ~/termux_install_failed.txt
  exit 1
fi

# Download script launcher from Aveely's repository
if [ ! -f ~/.scripts/$script2 ]; then
  echo -e "\e[0;32mDownloading script launcher from Aveely's repo\e[0m"
  wget -P ~/.scripts $script1
  chmod +x ~/.scripts/$script2
  if [ ! -f ~/.scripts/$script2 ]; then
    echo -e "\e[0;31mStop the script because the script launcher failed to install.\e[0m"
    echo "Rerun the script with executing: ./termux_setup.sh"
    exit 1
  fi
fi

# Backup user's files .bashrc and .bash_profile to make the new files configuration
mv ~/.bashrc ~/.bashrc_backup
if [ -f ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile_backup
fi

# Make the boot dialog if user have two scripts launcher
if [ -f ~/.scripts/startxfce4_termux.sh ] && [ -f ~/.scripts/startkde_termux.sh ] && [ ! -f ~/.scripts/boot_menu.sh ]; then
  cat << 'EOF' > ~/.scripts/boot_menu.sh
  #!/data/data/com.termux/files/usr/bin/bash

  show_menu() {
      CHOICE=$(dialog --clear \
                 --title "TERMUX BOOTING MENU" \
                  --menu "Choose one of them." \
                  9 43 2 \
                  1 "Termux Plasma Desktop (native)" \
                  2 "Termux XFCE4 Desktop (Native)" \
                  --stdout)
  
      case $CHOICE in
          1)
              clear
              echo "Starting Arch KDE Plasma..."
	            echo
              ~/.scripts/startkde_termux.sh
              ;;
          2)
              clear
              echo "Starting Termux XFCE4..."
	            echo
              ~/.scripts/startxfce4_termux.sh
              ;;
          *)
              clear
              ;;
      esac
  }

  show_menu
EOF

  chmod +x ~/.scripts/boot_menu.sh
  ln -sf ~/.scripts/boot_menu.sh ~/.D
fi

# Modify .bashrc and create .bash_profile
echo
echo 'Modifying file .bashrc and creating .bash_profile...'

# .bashrc
cat << 'EOF' > ~/.bashrc
# Script shortcuts.
alias xfceD="~/.scripts/startxfce4_termux.sh &"
alias kdeD="~/.scripts/startkde_termux.sh &"

# Command shortcuts.
alias slist="du -ah --max-depth=1"
alias killx11='echo "Killing Xorg11..." && kill -9 $(pgrep -f "termux.x11") 2>/dev/null'
EOF

# .bash_profile
cat << 'EOF' > ~/.bash_profile
# Login desktop confirmation.
echo
read -p "Login desktop? (y/N): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    clear
    echo "Entering desktop mode..."
    if [ -f ~/.D ]; then
      ~/.D
    fi
fi
clear

# Calling .bashrc if the file exists.
if [ -f ~/.bashrc ]
then
    source ~/.bashrc
fi
EOF

# Setup storage.
echo
echo -e "\e[0;33mTHIS IS OPTIONAL.\e[0m"
echo -e "\e[0;32mIf you want to link your device storage, please give the app permission to access your file.\e[0m"
echo -e "\e[0;32mYou can setup it anytime with executing: 'termux-setup-storage'.\e[0m"
echo
read -p "Link your device storage? (y/N): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo -e "\e[0;32mLinking...\e[0m"
    termux-setup-storage
fi

echo
echo -e "\e[0;32mTermux setup was completed!\e[0m"
echo -e "\e[0;32mPlease login-out and login-in to apply the change.\e[0m"
echo -e "\e[0;32m(Press: CTRL + D)\e[0m"

exit 0
