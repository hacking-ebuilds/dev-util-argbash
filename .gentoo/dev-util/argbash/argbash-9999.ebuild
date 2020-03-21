# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bash argument parsing code generator"
HOMEPAGE="https://github.com/matejak/argbash"
LICENSE="BSD-3"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/matejak/argbash.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/matejak/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS=""
IUSE="test"
SLOT="0"

RESTRICT="!test? ( test )"

RDEPEND=">=app-shells/bash-3.0
	>=sys-devel/autoconf-2.63"
DEPEND="test? ( ${RDEPEND} )"

S="${WORKDIR}/${P}/resources"

src_test() {
	emake unittests || die "emake unittests failed"
}

src_prepare() {
	default
	sed -Ei 's#m4dir=/\$\(PREFIXED_LIBDIR\)#m4dir=/\$(EROOT)usr/lib#' Makefile || die 'sed failed'
}

src_install() {
	emake PREFIX="${D}/usr" install || die "emake install failed"
	cd .. || die "'cd ..' failed"
	einstalldocs
}
