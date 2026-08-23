<h2 align=center>glitch-bane dotfiles<br>► ARCH ◄</h2>
<div align="center"><a href="#about">About</a> - <a href="#install">Install</a> - <a href="#usage">Usage</a> - <a href="#external-credit">Credit</a></div>
<hr/>

## About

This repository contains my personal dotfiles for configuring my flavor of Arch Linux. The setup uses Hyprland / Noctalia as the desktop environment (Wayland compositor) and is very minimal. My target machine is a `writer's terminal`, meaning very old hardware with the user's undistracted focus in mind. The goal of this configuration is to offer an easy and stylish provisioning agent for old thin-clients, which additionally utilizes bridge key-bindings/gestures similar to other operating systems.

- Linux Distro: **Arch-based Distributions**, *CachyOS*
- Wayland Compositor: **Hyprland**
- Desktop Shell: **Noctalia**
- Login Greeter: **Noctalia Greeter**

![Screenshot](.github/assets/screenshot-01.png)

<br/>

## Install

> [!NOTE] 
> CachyOS, being a rolling distribution, is very prone to unprecedented changes. I maintain these configurations by crossing them with the official base configuration repository to observe canon changes.

**Installation Instructions:**

For a barebones CachyOS installation, this project makes a few assumptions:
- Base CachyOS installed, current ISO version at time of commit: `260809`
- The Hyprland desktop environment was selected
- The Noctalia Greeter is used over SDDM

<br/>

**Provisioning Instructions:**

This project uses **GNU Stow** to manage dotfiles. Clone this repository in `$HOME`, `~`, or `/home/<NAME>/`, then run the provisioning script. CachyOS pre-installs a configuration, any conflicting directories will be moved to `~/.dotfiles-backup`.

```
git clone https://github.com/glitch-bane/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

chmod +x ./provisioner.sh
sudo ./provisioner.sh
```
<br/>

## Usage

**Custom Keybinds:** Keybinds are sourced in `~/.config/hypr/config/keybinds.lua`

- **Mod key**: Windows/Super Key
- **File Manager**: `Mod + e`

<br/>

**Trackpad Gestures:** Gestures are sourced in `~/.config/hypr/config/input.lua`

- **3 Fingers Swipe (L/R)**: Change Workspace

<br/>

## External Credit

- Wallpaper is attributed to *hold for source*.
