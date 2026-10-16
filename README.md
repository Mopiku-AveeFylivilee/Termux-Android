# 🛠 "REPOSITORY STILL IN PROGRESS"

# Termux-Android

Guide to install Termux, setup Termux using script, and running native Termux XFCE4 desktop on Termux:X11, and even running Arch Linux ARM64 PRoot with KDE Plasma desktop, (I only knew that DE installation for Arch Linux.) or other Linux Distros on proot-distro.

### You can visit the official [DroidMaster](https://github.com/LinuxDroidMaster/Termux-Desktops?tab=readme-ov-file) repository for more information.

<br>
<br>

# 📚 Index
* 🏁 [First steps](#first-steps)
* 📄 [Setup XFCE4 with scirpt](#setup-xfce4)
* 📋 [Shortcuts list](#shortcuts-list)

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

* The newest [Termux F-Droid](https://f-droid.org/packages/com.termux) (not the beta version.)
* Download the [Termux:X11](https://github.com/termux/termux-x11/releases/tag/nightly) universal debug apk.

in order for a full Linux desktop.

⚠️ Do not install Termux from Play Store!

Basic packages you need to install on Termux:

```
pkg update
pkg upgrade
pkg install x11-repo
pkg install termux-x11-nightly
pkg install tur-repo
pkg install pulseaudio
pkg install proot-distro
pkg install wget
pkg install git
```

<br>
<br>

---
<br>

# 📄 Setup Termux XFCE4 desktop using script<a name=setup-xfce4></a>
Download the script:
```
cd ~
wget https://raw.githubusercontent.com/Mopiku-AveeFylivilee/Termux-Android/refs/heads/main/scripts/Termux_setup/termux_setup.sh
```

Give the script permission, and execute it:
```
chmod +x termux_setup.sh && ./termux_setup.sh
```

After finished, to apply the change, please loging-out and loging-in.
* press (CTRL + D) to logout.

<br>
<br>

---
<br>

# 📋 Shortcuts list:<a name=shortcuts-list></a>
<table>
  <thead>
    <tr>
      <th scope="col" colspan="6">Type this to your Termux:</th>
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
      <td>To force-close X11 server. ⚠️ It can cause damages to your data! only use if you have problem with X11.</td>
    </tr>
  </tbody>
<table>

<br>
<br>

---
<br>

# 4🛠
