# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
inherit meson python-any-r1

DESCRIPTION="Terminal User Interface Widget Library"
HOMEPAGE="https://github.com/tuiwidgets/tuiwidgets"
LICENSE="Boost-1.0"
SRC_URI="https://github.com/tuiwidgets/tuiwidgets/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

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
	dev-qt/qtcore:5
	dev-cpp/catch
"

#PATCHES=(
#	"${FILESDIR}/"0001-tests-Add-missing-after-INFO.patch
#)

src_configure() {
	local emesonargs=(
		-Dsystem-catch2=enabled
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile

	if use doc; then
		sphinx-build -b html "${S}/doc" "${WORKDIR}/html" || die "sphinx-build failed"
	fi
}

src_install() {
	meson_src_install

	use doc && HTML_DOCS=( "${WORKDIR}/html/." )
	einstalldocs
}
