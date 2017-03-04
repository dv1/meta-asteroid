SUMMARY = "QML Plugin for contextkit on Nemo"
HOMEPAGE = "https://git.merproject.org/mer-core/nemo-qml-plugin-contextkit"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://src/plugin.cpp;beginline=1;endline=23;md5=bc596f90d6ca301d84447f4d365b9243"

SRC_URI = "git://git.merproject.org/mer-core-attic/nemo-qml-plugin-contextkit.git;protocol=https"
SRCREV = "ea0485fd84f5851d0671cfb3d2b9cec10a048890"
PR = "r1"
PV = "+git${SRCPV}"
inherit cmake_qt5
S = "${WORKDIR}/git"
B = "${S}"
EXTRA_OECMAKE+="-DUSEQT=5"

DEPENDS += "qtdeclarative statefs-qt"

do_configure_prepend() {
    sed -i "s@DESTINATION lib/qt5/qml/@DESTINATION lib/qml/@" src/CMakeLists.txt
}

FILES_${PN}-dbg += "/usr/lib/qml/org/freedesktop/contextkit/.debug/"
FILES_${PN} += "/usr/lib/qml/org/freedesktop/contextkit"
