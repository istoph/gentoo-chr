# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
inherit meson python-any-r1

DESCRIPTION="low level terminal interface library"
HOMEPAGE="https://github.com/textshell/posixsignalmanager"
LICENSE="Boost-1.0"
SRC_URI="https://github.com/textshell/posixsignalmanager/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"

SLOT="0"

IUSE="doc test tools"
RESTRICT="!test? ( test )"

BDEPEND="
	doc? ( >=dev-python/sphinx-3.3.1 )
	${PYTHON_DEPEND}
"
RDEPEND="
	sys-libs/termpaint
	dev-qt/qtcore:5
	test? ( dev-cpp/catch )
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

src_compile() {
	meson_src_compile
}

src_install() {
	use doc && HTML_DOCS=( "${WORKDIR}/html/." )
	meson_src_install
}
