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
    perl
    git
    python2
    python3
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

# This prevents passing flags to `ld` that it doesn't understand
options=(!buildflags)
install=
changelog=
# Jan Beulich
# [PATCH 0/3] x86/Dom0: support zstd compressed kernels
patches_zstd_dom0=(
)
patch_sha256sums_zstd_dom0=(
)
patches=()
patches+=(${patches_zstd_dom0[@]})
patch_sha256sums=()
patch_sha256sums+=(${patch_sha256sums_zstd_dom0[@]})
source=(
	"https://downloads.xenproject.org/release/xen/$pkgver/$pkgname-$pkgver.tar.gz"{,.sig}
    "https://src.fedoraproject.org/rpms/xen/raw/7794fedff39012c39ab4ba2c191f3e186fefc4eb/f/zstd-dom0.patch"

)
source+=(${patches[@]})
noextract=()
sha256sums=(
    "cf0d7316ad674491f49b7ef0518cb1d906a2e3bfad639deef0ef2343b119ac0c"
    "8936f8da3c4981e4deadface3c4178e292d337b77073002826a008a64d5fe450"
    e40aa4f0527679e91ce27fdc361cb744221cb8ebcfdc41eb7662572fe667612e
)
sha256sums+=(${patch_sha256sums[@]})
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
	sed 's,/var/run,/run,g' -i tools/hotplug/Linux/locking.sh
	sed 's,/var/run,/run,g' -i tools/misc/xenpvnetboot
	sed 's,/var/run,/run,g' -i tools/xenmon/xenbaked.c
	sed 's,/var/run,/run,g' -i tools/xenmon/xenmon.py
	sed 's,/var/run,/run,g' -i tools/pygrub/src/pygrub
    #perl -0777 -i.original -pe 's/^.*<!--X-Body-of-Message-->\n<pre>//igs' $file

    # Zstd compressed dom0 kernel patches
    patch -p1 -i ../zstd-dom0.patch
}

#pkgver() {
#    # used to set versions, e.g. if build from git
#    # `pkgver` cannot contain spaces
#    true
#}

build() {
	cd "$pkgname-$pkgver"
		#--with-sysconfig-leaf-dir=conf.d \
    make distclean
    make clean
	./configure \
        --prefix=/usr \
		--sbindir=/usr/bin \
		--libdir=/usr/lib \
		--with-rundir=/run \
		--with-system-seabios=/usr/share/qemu/bios-256k.bin \
		--with-system-ovmf=/usr/share/ovmf/x64/OVMF.fd \
        --disable-stubdom \
		--disable-qemu-traditional \
        --enable-systemd
	#make -j$(nproc) DESTDIR="$pkgdir/" XEN_VENDORVERSION=arch
	make -j$(nproc) XEN_VENDORVERSION=arch
}

check() {
	#cd "$pkgname-$pkgver"
	#make -k check
    true
}

package() {
	cd "$pkgname-$pkgver"
	#make DESTDIR="$pkgdir/" XEN_VENDORVERSION=arch install
	make DESTDIR="$pkgdir/" install
}
