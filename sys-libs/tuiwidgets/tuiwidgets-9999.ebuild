# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
inherit meson python-any-r1

DESCRIPTION="Terminal User Interface Widget Library"
HOMEPAGE="https://github.com/tuiwidgets/tuiwidgets"
LICENSE="Boost-1.0"
if [[ ${PV} == *9999 ]]; then
    EGIT_REPO_URI="https://github.com/tuiwidgets/tuiwidgets"
    inherit git-r3
else
    SRC_URI="https://github.com/tuiwidgets/tuiwidgets/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS=""

SLOT="0"

IUSE="doc test"

RESTRICT="!test? ( test )"

BDEPEND="
	doc? ( >=dev-python/sphinx-3.3.1 dev-python/beautifulsoup4 )
	${PYTHON_DEPEND}
"
RDEPEND="
	sys-libs/termpaint
	sys-libs/posixsignalmanager
	dev-qt/qtcore:5
	test? ( dev-cpp/catch )
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	local emesonargs=(
		-Dsystem-catch2=enabled
		-Dtests=$(usex test true false)
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
	use doc && HTML_DOCS=( "${WORKDIR}/html/." )
	meson_src_install
}
