# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1

DESCRIPTION="Sphinx extension to include images with additional options"
HOMEPAGE="https://github.com/sphinx-contrib/images"
SRC_URI="https://github.com/sphinx-contrib/images/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/images-${PV}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

# RUNTIME DEPENDENCIES
RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

# BUILD-TIME DEPENDENCIES
DEPEND="
	${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
}

