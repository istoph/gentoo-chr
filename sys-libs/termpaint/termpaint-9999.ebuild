# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
EGIT_REPO_URI="https://github.com/termpaint/termpaint"
inherit git-r3 meson python-any-r1

DESCRIPTION="low level terminal interface library"
HOMEPAGE="https://github.com/termpaint/termpaint"
LICENSE="Boost-1.0"

SLOT="0"

IUSE="doc test tools"
RESTRICT="!test? ( test )"

BDEPEND="
	doc? ( >=dev-python/sphinx-3.3.1 )
	${PYTHON_DEPEND}
"
RDEPEND=""
DEPEND="
	dev-cpp/picojson
	test? ( dev-cpp/catch:0 )
"

PATCHES=(
	"${FILESDIR}/"0004-meson.build-Guard-tests-and-maintainer-targets-behin.patch
)

src_configure() {
	local emesonargs=(
		-Dbuild-tests=$(usex test true false)
		-Dmaintainer-mode=false

		-Dsystem-catch2=enabled
		-Dsystem-picojson=enabled

		-Dttyrescue-fexec-blob=false
		-Dttyrescue-path="${EPREFIX}/usr/libexec/termpaint"
		-Dttyrescue-install=true

		-Dtools-path=$(usex tools "${EPREFIX}/usr/libexec/termpaint" "")
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile

	if use doc; then
		sphinx-build -b html "${S}/doc" "${WORKDIR}/html" || die "sphinx-build failed"
	fi
}

src_test() {
	meson_src_test
}

src_install() {
	use doc && HTML_DOCS=( "${WORKDIR}/html/." )
	meson_src_install
}
