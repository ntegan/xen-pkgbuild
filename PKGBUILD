# Maintainer: Nick Egan <ntegan1@gmail.com>
pkgname=xen
pkgver=4.14.1
pkgrel=1
#epoch=
pkgdesc="Xen hypervisor"
arch=('x86_64')
url="xenproject.org"
license=('GPL2')
#groups=()
depends=()
    # python-dev (python2)
    # uuid-dev, 
makedepends=(
    git
    python2
    zlib
    ncurses
    openssl
    xorg-server-devel
    util-linux-libs
    yajl
    libaio
    glib2
    pixman
    pkgconf
    bridge-utils
    iproute2
    bison
    flex
    gettext
    acpica
    glibc
    lib32-glibc
    figlet
    
)
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=(
	"https://downloads.xenproject.org/release/xen/$pkgver/$pkgname-$pkgver.tar.gz"{,.sig}
)
#source=("$pkgname-$pkgver.tar.gz"
#        "$pkgname-$pkgver.patch")
noextract=()
sha256sums=(
    "cf0d7316ad674491f49b7ef0518cb1d906a2e3bfad639deef0ef2343b119ac0c"
    "8936f8da3c4981e4deadface3c4178e292d337b77073002826a008a64d5fe450"
)
# Xen.org Xen tree code signing <pgp@xen.org>
#(signatures on the xen hypervisor and tools) 
validpgpkeys=(
    "23E3222C145F4475FA8060A783FE14C957E82BD9"
)

## makepkg defined variables
# `srcdir` points to extracted src files?
# `pkgdir` dir where package is bundled

## TODO check that it works
# `namcap` pkgbuild
# `namcap` package.pkg.tar.zst

prepare() {
    # runs after package extraction
    # before pkgver() and build function
    # if extract skipped, this not run
	cd "$pkgname-$pkgver"
	#patch -p1 -i "$srcdir/$pkgname-$pkgver.patch"
}

#pkgver() {
#    # used to set versions, e.g. if build from git
#    # `pkgver` cannot contain spaces
#    true
#}

build() {
	cd "$pkgname-$pkgver"
		#--with-system-ovmf=/usr/share/ovmf/x64/OVMF.fd \
		#--with-system-seabios=/usr/share/qemu/bios-256k.bin \
		#--with-sysconfig-leaf-dir=conf.d \
	./configure \
        --prefix=/usr \
		--sbindir=/usr/bin \
		--libdir=/usr/lib \
		--with-rundir=/run \
        --disable-stubdom \
		--disable-qemu-traditional \
        --enable-systemd
	make -j$(nproc) XEN_VENDORVERSION=arch
}

check() {
	#cd "$pkgname-$pkgver"
	#make -k check
    true
}

package() {
	cd "$pkgname-$pkgver"
	make DESTDIR="$pkgdir/" install
}
