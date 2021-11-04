#!/bin/bash

function install_kernel_params () {
    if [ ! -f /boot/.config_noscreen.txt ]; then
	echo "Hyperpixel not installed, backuping current cmdline state."
	cp /boot/config.txt /boot/.config_noscreen.txt
    fi
    grep -q dtoverlay=hyperpixel /boot/config.txt ||
	cat <<EOF >> /boot/config.txt
dtoverlay=hyperpixel
overscan_left=0
overscan_right=0
overscan_top=0
overscan_bottom=0
framebuffer_width=800
framebuffer_height=480
enable_dpi_lcd=1
display_default_lcd=1
dpi_group=2
dpi_mode=87
dpi_output_format=0x6f016
display_rotate=2
hdmi_timings=800 0 50 20 50 480 1 3 2 3 0 0 0 60 0 32000000 6
dtoverlay=hyperpixel-gpio-backlight
EOF
}

#
# POST INSTALL
#

function post_install () {
    # update kernel parameters
    install_kernel_params

    # enable systemd service
    systemctl enable hyperpixel-init
    systemctl enable hyperpixel-touch


    echo "/!\ Kernel Reboot needed to get device working /!\ "
}

#
# POST UPGRADE
#

function post_upgrade () {
    install_kernel_params
    systemctl daemon-reload
}

#
# PRE REMOVE
#

function pre_remove () {
    systemctl disable hyperpixel-init
    systemctl disable hyperpixel-touch

    if [ -f /boot/.config_noscreen.txt ]; then
	echo "Restoring old cmdline state"
	/boot/.config_noscreen.txt /boot/config.txt
    fi
}
