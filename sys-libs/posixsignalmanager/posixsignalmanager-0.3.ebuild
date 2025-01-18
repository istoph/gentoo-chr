# Copyright 2024 Christoph Hueffelmann <chr@istoph.de>

EAPI=8

inherit meson

DESCRIPTION="low level terminal interface library"
HOMEPAGE="https://github.com/textshell/posixsignalmanager"
LICENSE="Boost-1.0"
SRC_URI="https://github.com/textshell/posixsignalmanager/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"

SLOT="0"

IUSE=""

RDEPEND="
	sys-libs/termpaint
	dev-qt/qtcore:5
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	local emesonargs=(
		-Dsystem-catch2=disabled
	)
	meson_src_configure
}

