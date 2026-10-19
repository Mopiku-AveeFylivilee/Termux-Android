# 🛠 "REPOSITORY STILL IN PROGRESS"

# Termux-Android

Termux is a Linux terminal environtment, you can connect a server via SSH, coding/programming with VS Code, Vim, Nano, LibreOffice for office work, Kdenlive for video editing 'if your phone strong enough', and other applications. (Note that not all Applications suport Termux.)

(OPTIONAL) running Arch Linux ARM64 PRoot with KDE Plasma desktop or XFCE4, (I only know two DE installation for Arch Linux.) or other Linux Distros on proot-distro for many apps support compare to Termux native.

<br>
<br>

## Requirement:
* 5 GiB of free storage.
* Termux F-Droid or GitHub version. (not from Play Store.)
* Termux:X11 for graphical user interface.

<br>
<br>

## Instalation:
Install Termux, setup Termux and XFCE4 using script, running XFCE4 desktop on Termux:X11. Instruction below⬇️

<br>

### You can visit the official [DroidMaster](https://github.com/LinuxDroidMaster/Termux-Desktops?tab=readme-ov-file) repository for more details and information.

<br>
<br>

# 📚 Index
* 🏁 [First steps](#first-steps)
* 🐀 [Setup XFCE4 with script](#setup-xfce4)
* 📋 [Shortcut list](#shortcuts-list)

<br>
<br>

---
<br>


# Termux Environment Preview

| Native |
|---------------------------------------------|
| <img src="/Documentation/images/preview_native.jpg"/> |


---
<br>
<br>


# 🏁 First <a name=first-steps></a>
you need to install:

* [Termux F-Droid](https://f-droid.org/packages/com.termux) (not the beta version.)
* [Termux:X11](https://github.com/termux/termux-x11/releases/tag/nightly) universal debug apk.

in order for a full Linux desktop.

⚠️ Do not install Termux from Play Store!

Update Termux and install wget:

```
pkg update
pkg upgrade
pkg install wget
```

<br>
<br>

---
<br>

# 🐀 Setup Termux XFCE4 desktop using script<a name=setup-xfce4></a>
Download the script:
```
cd ~
wget https://raw.githubusercontent.com/Mopiku-AveeFylivilee/Termux-Android/refs/heads/main/scripts/Termux_setup/termux_setup.sh
```

Give the script permission, and execute it:
```
chmod +x termux_setup.sh
./termux_setup.sh
```

After finished, to apply the change, please loging-out and loging-in.
* press (CTRL + D) to logout.

<br>
<br>

---
<br>

# 📋 Shortcuts list:<a name=shortcuts-list>
<table>
  <thead>
    <tr>
      <th scope="col" colspan="6">Instructions</th>
    </tr>
    <tr>
        <th scope="col">Shortcuts:</th>
        <th scope="col">Information:</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>desktop</td>
      <td>To start XFCE4 desktop.</td>
    </tr>
    <tr>
      <td>xorg11</td>
      <td>To start X11 without desktop environment.</td>
    </tr>
    <tr>
      <td>killx11</td>
      <td>To force-close X11 server. ⚠️ It can cause damages to your data & system! Only use if you really want to kill X11.</td>
    </tr>
  </tbody>
<table>
Don't run multiple desktop launchers at the same time, it's just like 'killx11' that force-close X11 server.
  
<br>
<br>

---
<br>

# 4🛠
