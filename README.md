# 🛠 "REPOSITORY STILL IN PROGRESS"

# Termux-Android

Guide to install Termux, setup Termux with script, and running native Termux XFCE4 desktop on Termux:X11, and even running Arch Linux ARM64 PRoot with KDE Plasma desktop, (I only knew that DE installation for Arch Linux.) or other Linux Distros on proot-distro.

### You can visit the official [DroidMaster](https://github.com/LinuxDroidMaster/Termux-Desktops?tab=readme-ov-file) repository for more information.

<br>
<br>

# 📚 Index
* 🏁 [First steps](#first-steps)

<br>
<br>

---
<br>

# 🏁 First <a name=first-steps></a>
you need to install:

* [Termux F-Droid](https://f-droid.org/packages/com.termux)
* Download the [Termux:X11](https://github.com/termux/termux-x11/releases/tag/nightly) arm64 or universal apk.

in order for a full Linux desktop.

⚠️ Do not install Termux from Play Store!

Basic packages you need to install on Termux:

```
pkg update
pkg upgrade -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install tur-repo -y
pkg install pulseaudio -y
pkg install proot-distro -y
pkg install wget -y
pkg install git -y
```

<br>
<br>

---
<br>

# 2
