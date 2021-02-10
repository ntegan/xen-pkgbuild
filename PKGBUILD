# Maintainer: Nick Egan <ntegan1@gmail.com>
pkgname=xen
pkgver=4.14.1
pkgrel=1
#epoch=
pkgdesc="Type-1 hypervisor"
arch=('x86_64')
url="xenproject.org"
license=('GPL2')
#groups=()
depends=(
    python
    python3
    libaio
    glib2
    pixman
    curl
    libxml2
    yajl
    gnutls
    libnl
    libseccomp
    systemd-libs
)
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
install="xen.install"
changelog=
patches=()
patch_sha256sums=()
source=(
    "https://downloads.xenproject.org/release/xen/$pkgver/$pkgname-$pkgver.tar.gz"{,.sig}
    "https://src.fedoraproject.org/rpms/xen/raw/7794fedff39012c39ab4ba2c191f3e186fefc4eb/f/zstd-dom0.patch"
    tmpfiles.conf
    xen.conf
    xen.install
)
source+=(${patches[@]})
noextract=()
sha256sums=(
    "cf0d7316ad674491f49b7ef0518cb1d906a2e3bfad639deef0ef2343b119ac0c"
    "8936f8da3c4981e4deadface3c4178e292d337b77073002826a008a64d5fe450"
    e40aa4f0527679e91ce27fdc361cb744221cb8ebcfdc41eb7662572fe667612e
    40e0760810a49f925f2ae9f986940b40eba477dc6d3e83a78baaae096513b3cf
    50a9b7fd19e8beb1dea09755f07318f36be0b7ec53d3c9e74f3266a63e682c0c
    e1d4868ff68ce17d595f0989ad4ed70c17170fe6b5d6a82f7cdd7d087d377e06
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
        #--with-extra-qemuu-configure-args="--enable-spice " \
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

    # lib64->lib, rename to xen.efi, remove softlinks
    mv "$pkgdir"/usr/lib64/efi "$pkgdir"/usr/lib/efi
    rm -rf "$pkgdir"{/var/run,/usr/lib64}
    find "${pkgdir}/usr/lib/efi" -type l -delete
    mv "${pkgdir}/usr/lib/efi/xen-${pkgver}.efi" "${pkgdir}/usr/lib/efi/xen.efi"

    mkdir -p "${pkgdir}/var/log/xen/console"

    # rename to xen.gz
    find "${pkgdir}/boot" -type l -delete
    mv "${pkgdir}/boot/xen-${pkgver}.gz" "${pkgdir}/boot/xen.gz"

    # Remove debug symbols
    rm -r "${pkgdir}/usr/lib/debug"

    # SysVinit
    rm -r "${pkgdir}/etc/init.d"

    # xen.conf (mdoules load) TODO do i need this or nah
    install -D -m 0644 "${srcdir}/xen.conf" "${pkgdir}/usr/lib/modules-load.d/xen.conf"
    # efi-xen.cfg
    # tmpfiles
    install -D -m 0644 "${srcdir}/tmpfiles.conf" "${pkgdir}/usr/lib/tmpfiles.d/${pkgbase}.conf"
    # microcode hooks
}

# TODO
#vendor_id       : AuthenticAMD
#cpu family      : 23
#model           : 113
#model name      : AMD Ryzen 9 3950X 16-Core Processor
#https://intrbiz.com/post/blog/linux/setting-the-cpuid-of-a-xen-guest
#cpuid = [ '0:eax=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx,ebx=01101000011101000111010101000001,ecx=01000100010011010100000101100011,edx=01101001011101000110111001100101',
#          '1:eax=00000000000000000000000000000000,ebx=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx,ecx=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx,edx=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
#'36507222018:eax=00100000010001000100110101000001,ebx=01100101011110100111100101010010,ecx=00100000001110010010000001101110,edx=00110000001101010011100100110011',
#'36507222019:eax=00110110001100010010000001011000,ebx=01110010011011110100001100101101,ecx=01110010010100000010000001100101,edx=01110011011001010110001101101111',
#'36507222020:eax=00000000011100100110111101110011,ebx=00000000000000000000000000000000,ecx=00000000000000000000000000000000,edx=00000000000000000000000000000000']


