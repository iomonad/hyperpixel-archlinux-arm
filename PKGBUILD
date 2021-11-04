# Maintainer: iomonad <me@trosa.io>

pkgname=hyperpixel-screen
pkgver=1.0
pkgrel=1
pkgdesc="A package that aims to remplace Pimoroni's setup script for ARM Archlinux platform"
arch=('armv6h' 'armv7h' 'aarch64')
url="https://github.com/iomonad/hyperpixel-archlinux-arm"
license=('MIT')
depends=(python-evdev) #smbus needed
makedepends=(libbcm2835)
conflicts=(hyperpixel) # from AUR
install=install.sh

build() {
  cd ${srcdir}/../

  cc -o hyperpixel-init hyperpixel-init.c -lbcm2835 -pedantic
}

package() {
  cd ${srcdir}/../

  install -dm755 ${pkgdir}/boot/overlays
  install -dm755 ${pkgdir}/usr/bin
  install -dm755 ${pkgdir}/usr/lib/systemd/system

  install -sm755 hyperpixel-init ${pkgdir}/usr/bin
  install -m644 blobs/overlays/*.dtbo ${pkgdir}/boot/overlays
  install -m755 binaries/hyperpixel-touch ${pkgdir}/usr/bin
  install -m644 systemd/*.service ${pkgdir}/usr/lib/systemd/system

  sed -i '1 s:python$:python2:' ${pkgdir}/usr/bin/hyperpixel-touch
}
