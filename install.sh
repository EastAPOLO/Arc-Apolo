#!/bin/bash

NAME=$(cat "./index.theme" | grep "Name" | sed 's/.*=\(.*\)/\1/')
TARGET="/usr/share/themes/$NAME"

if [[ "$NAME" == "" ]]; then
    echo "Invalid Theme name."
    exit
fi

# Remove old directories
rm -rfv "$TARGET"

# Create required directories
mkdir -pv "$TARGET/gtk-3.0"
mkdir -pv "$TARGET/gtk-2.0"
mkdir -pv "$TARGET/metacity-1"

# Move theme info to the root theme dir
cp -v "./index.theme" "$TARGET/index.theme"

# Copy gtk3 files to the gtk3 folder
cp -v "./gtk3/gtk.css" "$TARGET/gtk-3.0/gtk.css"
cp -v "./gtk3/thumbnail.png" "$TARGET/gtk-3.0/thumbnail.png"
cp -rv "./gtk3/assets/" "$TARGET/gtk-3.0/assets"

# Copy gtk2 files to the gtk2 folder
cp -v "./gtk2/gtkrc" "$TARGET/gtk-2.0/gtkrc"
cp -v "./gtk2/apps.rc" "$TARGET/gtk-2.0/apps.rc"
cp -v "./gtk2/xfce-notify.rc" "$TARGET/gtk-2.0/xfce-notify.rc"
cp -v "./gtk2/main.rc" "$TARGET/gtk-2.0/main.rc"
cp -rv "./gtk2/assets" "$TARGET/gtk-2.0/assets"
cp -rv "./gtk2/menubar-toolbar" "$TARGET/gtk-2.0/menubar-toolbar"

# Copy metacity files to metacity folder
cp -v "./metacity/metacity-theme-2.xml" "$TARGET/metacity-1/"
cp -v "./metacity/metacity-theme-3.xml" "$TARGET/metacity-1/"
cp -rv "./metacity/assets/." "$TARGET/metacity-1/"
