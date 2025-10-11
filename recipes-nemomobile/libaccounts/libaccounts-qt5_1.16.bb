SUMMARY = "Accounts management library for Qt applications"
HOMEPAGE = "https://gitlab.com/accounts-sso/libaccounts-qt"
LICENSE = "LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=243b725d71bb5df4a1e5920b344b86ad"

inherit qmake5 pkgconfig

SRC_URI = "git://gitlab.com/accounts-sso/libaccounts-qt.git;protocol=https;branch=master \
           file://0001-Remmove-tests-and-doc-from-build.patch \
           "

SRCREV = "525ec684cfa8d234f797d7e49e21c476eea04d8e"
S = "${WORKDIR}/git"

DEPENDS += "qtbase libaccounts-glib"

FILES:${PN}-dev += "${libdir}/cmake"
