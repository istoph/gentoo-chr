# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
inherit meson

DESCRIPTION="Terminal User Interface Widget Library"
HOMEPAGE="https://github.com/tuiwidgets/tuiwidgets"
LICENSE="Boost-1.0"
SRC_URI="https://github.com/tuiwidgets/tuiwidgets/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"

SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	${PYTHON_DEPEND}
"
RDEPEND="
	sys-libs/termpaint
	sys-libs/posixsignalmanager
	dev-qt/qtcore:5
	dev-cpp/catch
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	local emesonargs=(
		-Dsystem-catch2=enabled
	)
	meson_src_configure
}
