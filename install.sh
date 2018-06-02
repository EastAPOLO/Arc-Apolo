#!/bin/bash

NAME=$(cat "./index.theme" | grep "Name" | sed 's/.*=\(.*\)/\1/')
TARGET="/usr/share/themes/$NAME"

if [[ "$NAME" == "" ]]; then
    echo "Invalid Theme name."
    exit
fi

# Remove old directories
sudo rm -rfv "$TARGET"

# Create required directories
sudo mkdir -pv "$TARGET/gtk-3.0"
sudo mkdir -pv "$TARGET/gtk-2.0"
sudo mkdir -pv "$TARGET/metacity-1"
sudo mkdir -pv "$TARGET/cinnamon"

# Move theme info to the root theme dir
sudo cp -v "./index.theme" "$TARGET/index.theme"

# Copy gtk3 files to the gtk3 folder
sudo cp -v "./gtk3/gtk.css" "$TARGET/gtk-3.0/gtk.css"
sudo cp -v "./gtk3/thumbnail.png" "$TARGET/gtk-3.0/thumbnail.png"
sudo cp -rv "./gtk3/assets/" "$TARGET/gtk-3.0/assets"

# Copy gtk2 files to the gtk2 folder
sudo cp -v "./gtk2/gtkrc" "$TARGET/gtk-2.0/gtkrc"
sudo cp -v "./gtk2/apps.rc" "$TARGET/gtk-2.0/apps.rc"
sudo cp -v "./gtk2/xfce-notify.rc" "$TARGET/gtk-2.0/xfce-notify.rc"
sudo cp -v "./gtk2/main.rc" "$TARGET/gtk-2.0/main.rc"
sudo cp -v "./gtk2/panel.rc" "$TARGET/gtk-2.0/panel.rc"
sudo cp -rv "./gtk2/assets" "$TARGET/gtk-2.0/assets"
sudo cp -rv "./gtk2/menubar-toolbar" "$TARGET/gtk-2.0/menubar-toolbar"

# Copy metacity files to metacity folder
sudo cp -v "./metacity/metacity-theme-2.xml" "$TARGET/metacity-1/"
sudo cp -v "./metacity/metacity-theme-3.xml" "$TARGET/metacity-1/"
sudo cp -rv "./metacity/assets/." "$TARGET/metacity-1/"
