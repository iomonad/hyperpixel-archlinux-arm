# Maintainer: iomonad <me@trosa.io>

pkgname=hyperpixel-screen
pkgver=1.0
pkgrel=1
pkgdesc="A package that aims to remplace Pimoroni's setup script for ARM Archlinux platform"
arch=('armv6h' 'armv7h' 'aarch64')
url="https://github.com/iomonad/hyperpixel-archlinux-arm"
license=('MIT')
depends=(python-evdev python-smbus-git python2-rpi.gpio)
makedepends=()
checkdepends=()
optdepends=()
conflicts=(hyperpixel) # from AUR
install=install.sh
noextract=()
md5sums=(SKIP)


build() {
	cd ${srcdir}/${_gitdir}/sources

	cc -o hyperpixel-init hyperpixel-init.c -lbcm2835
}

package() {
	cd ${srcdir}/${_gitdir}

	install -dm755 ${pkgdir}/boot/overlays
	install -dm755 ${pkgdir}/usr/bin
	install -dm755 ${pkgdir}/usr/lib/systemd/system
	install -sm755 sources/hyperpixel-init ${pkgdir}/usr/bin
	install -m644 requirements/boot/overlays/*.dtbo ${pkgdir}/boot/overlays
	install -m755 requirements/usr/bin/hyperpixel-touch ${pkgdir}/usr/bin
	install -m644 requirements/usr/lib/systemd/system/*.service ${pkgdir}/usr/lib/systemd/system

	sed -i '1 s:python$:python2:' ${pkgdir}/usr/bin/hyperpixel-touch
}
