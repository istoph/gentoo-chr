# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>

EAPI=8

inherit meson

DESCRIPTION="Console-based editor designed for simplified use like gedit"
HOMEPAGE="https://github.com/istoph/editor"
LICENSE="Boost-1.0"

if [[ ${PV} == *9999 ]]; then
    EGIT_REPO_URI="https://github.com/istoph/editor"
    inherit git-r3
else
    SRC_URI="https://github.com/istoph/editor/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
    S=${WORKDIR}/editor-${PV}
fi


KEYWORDS=""

SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	sys-libs/tuiwidgets
	dev-qt/qtconcurrent:5
	test? ( dev-cpp/catch )
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	local emesonargs=(
        -Dtests=$(usex test true false)
		-Dsystem-catch2=enabled
		-Dversion=${PVR}
	)
	meson_src_configure
}
