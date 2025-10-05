inherit core-image
inherit extrausers
LICENSE = "GPL-2.0-only"

# Inherit this to be able to produce OE SDKs that are fully capable of building Qt5 code
inherit populate_sdk_qt5
inherit asteroid-users

IMAGE_FEATURES += "package-management empty-root-password allow-empty-password allow-root-login"

IMAGE_INSTALL += " \
kernel-modules base-files base-passwd systemd busybox iproute2 connman pam-plugin-loginuid bluez5 polkit polkit-group-rule-datetime \
pulseaudio-server openssh-sshd openssh-sftp-server openssh-scp dsme mce ngfd nfcd timed sensorfw resize-rootfs mapplauncherd-booster-qtcomponents usb-moded ofono \
${@oe.utils.conditional('MACHINE_HAS_WLAN', 'true', 'iproute2 wpa-supplicant connman-client', '', d)} \
qtgraphicaleffects-qmlplugins supported-languages ttf-asteroid-fonts asteroid-launcher asteroid-calculator asteroid-calendar asteroid-stopwatch asteroid-settings asteroid-timer asteroid-alarmclock asteroid-weather asteroid-music asteroid-btsyncd asteroid-flashlight asteroid-diamonds"

IMAGE_OVERHEAD_FACTOR = "1.0"
IMAGE_ROOTFS_EXTRA_SPACE = "131072"

EXTRA_IMAGECMD:ext4 += " -O^metadata_csum"

DEPENDS:append = " ${@oe.utils.conditional('GENERATE_SPARSE_IMAGE', 'true', 'android-simg2img-native', '', d)} "

generate_sparse_image() {
    if [ -n "${GENERATE_SPARSE_IMAGE}" ]; then
        img2simg "${IMGDEPLOYDIR}/${IMAGE_NAME}.ext4" "${IMGDEPLOYDIR}/${IMAGE_NAME}.simg"
        ln -s "${IMAGE_NAME}.simg" "${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.simg"
    fi
}

IMAGE_POSTPROCESS_COMMAND:append = " generate_sparse_image ; "

# This defines what shell to use for interactive use, that is,
# when users log in and type in commands. The default shell is
# not affected by this, however.
#
# This allows for keeping the default shell that runs scripts
# unchanged, while switching the interactive shell to something
# more sophisticated, like bash. This is useful for debugging
# and development. Thus, this variable is usually modified by
# development images, not production ones.
DEFAULT_INTERACTIVE_SHELL ?= "/bin/sh"

# Set the interactive shell for root and ceres.
# There are no other users that need this setting.
EXTRA_USERS_PARAMS += '\
    usermod -s "${DEFAULT_INTERACTIVE_SHELL}" root; \
    usermod -s "${DEFAULT_INTERACTIVE_SHELL}" ceres; \
'
