# Arc-Apolo
#### A simplified GTK Arc Theme

Disclaimer: Credit for most of this goes to the original Arc Theme.
You can find it here: https://github.com/horst3180/arc-theme

### Description
This is a fork of the Arc theme, specifically the variant `Arc-Dark`. I do not care for the other variants and the aim of this theme is to be simple and easy to modify. When I have the time I plan to add support for Desktop Environments in the future.

### Installation

All you need to do to install this theme is run `install.sh` as root (or any other user that has access to `/usr/share/themes`) and the theme is ready to use.

### Hacking
This theme aims to be easy to configure and change. If you want to edit the gtk3 theme, you only have to edit the `gtk.css`.
For the gtk2 theme you'll have to edit the `gtkrc` file. Both gtk2 and gtk3 have an `assets.svg` file for the images.

There are only a few colors which have been used in the creation of this theme, these are:
 * `#1C1C1C` as primary background color
 * `#1A1717` as secondary background color
 * `#DADADA` as primary foreground color
 * `#3A85E2` as highlight color
 * `#2D2D2D` as border color
 * `#2B2B2B` as button and input box color

Once you change the `assets.svg` file you'll have to regenerate the assets using the `render-assets.sh` script.
This requires `inkscape` and optionally `optipng` for compressing the output images.

If you want to change the name of the theme, all you have to do is edit the `index.theme` file and replace every occurance of `Arc-Apolo` with the new name.

After changing anything, you'll have to reinstall the theme using the `install.sh` script.

