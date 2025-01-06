# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{9..13} )
inherit meson python-any-r1

DESCRIPTION="low level terminal interface library"
HOMEPAGE="https://github.com/istoph/editor"
LICENSE="Boost-1.0"
SRC_URI="https://github.com/istoph/editor/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/editor-${PV}

KEYWORDS=""

SLOT="qt5"

IUSE="doc test tools"
RESTRICT="!test? ( test )"

BDEPEND="
	doc? ( >=dev-python/sphinx-3.3.1 )
	${PYTHON_DEPEND}
"
RDEPEND=""
DEPEND="
	sys-libs/termpaint
        sys-libs/posixsignalmanager
        sys-libs/tuiwidgets
	dev-qt/qtcore:5
        dev-qt/qtconcurrent:5
	dev-cpp/catch
"

#PATCHES=(
#	"${FILESDIR}/"0001-tests-Add-missing-after-INFO.patch
#)

src_configure() {
	local emesonargs=(
		-Dsystem-catch2=enabled
                -Dversion=${PVR}
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
