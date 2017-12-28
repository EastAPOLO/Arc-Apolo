#! /bin/bash
#
# This file is part of adapta-gtk-theme
#
# Copyright (C) 2016-2017 Tista <tista.gma500@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#

INKSCAPE="`command -v inkscape`"

SRC_DIR="./metacity-assets"
ASSETS_DIR="./assets"
INDEX="./assets.txt"
KEY_FILE="./key-colors.scss"
RECOLOR_FILE1="./metacity-assets/button_close_pressed.svg"
RECOLOR_FILE2="./metacity-assets/button_close_prelight.svg"
COL_FILE="./colors.scss"

# Default colours
selection1="`grep 'Cyan500' $COL_FILE | \
                   cut -d' ' -f3`"
destruction1="`grep 'RedA200' $COL_FILE | \
                     cut -d' ' -f3`"

# Check and re-color 'button_close_pressed' button
if [ -e $KEY_FILE ]; then
    selection2="`grep 'key_selection' $KEY_FILE | \
                 cut -d' ' -f2 | cut -d';' -f1`"
    destruction2="`grep 'key_destruction' $KEY_FILE | \
                   cut -d' ' -f2 | cut -d';' -f1`"

    cp -f $RECOLOR_FILE1.in $RECOLOR_FILE1
    cp -f $RECOLOR_FILE2.in $RECOLOR_FILE2

    if [ $selection1 != $selection2 ]; then
        sed -i "s/$selection1/$selection2/gi" $RECOLOR_FILE1
        echo $selection1 is re-colored with $selection2.
    fi

    if [ $destruction1 != $destruction2 ]; then
        sed -i "s/$destruction1/$destruction2/gi" $RECOLOR_FILE2
        echo $destruction1 is re-colored with $destruction2.
    fi
else
    echo _key_colors.scss was not found. Stopped...
    exit 1
fi

# Clone stock SVG files
for i in $(<$INDEX)
do
    if [ -f $ASSETS_DIR/$i.svg ] && \
        [ $SRC_DIR/$i.svg -ot $ASSETS_DIR/$i.svg ]; then
        echo $ASSETS_DIR/$i.svg exists.
    else
        echo Cloning $ASSETS_DIR/$i.svg
        cp $SRC_DIR/$i.svg $ASSETS_DIR
    fi
done

inkver="`$INKSCAPE --version | awk '{print $2}' | cut -c 1-4`"
if [ "$inkver" = 0.91 ]; then
    non_scale_dpi=90
else
    non_scale_dpi=96
fi

# Renderer
render-non-scale() {
    $INKSCAPE --export-dpi="$non_scale_dpi" \
              --export-png=$ASSETS_DIR/$i.png $SRC_DIR/$i.svg >/dev/null \
                                                              2>>../inkscape.log
}

# Generate PNG files
for i in $(<$INDEX)
do 
    if [ -f $ASSETS_DIR/$i.png ] && \
        [ $KEY_FILE -ot $ASSETS_DIR/$i.png ]; then
        echo $ASSETS_DIR/$i.png exists.
    elif [ -f $ASSETS_DIR/$i.png ] && \
        [ $KEY_FILE -nt $ASSETS_DIR/$i.png ]; then
        echo Re-rendering $ASSETS_DIR/$i.png
        echo $i.png >>../inkscape.log
        rm -f $ASSETS_DIR/$i.png
        render-non-scale
    else
        echo Rendering $ASSETS_DIR/$i.png
        echo $i.png >>../inkscape.log
        render-non-scale
    fi
done

exit 0
