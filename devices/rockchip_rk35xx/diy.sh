#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/feeds/kiddin9/accel-ppp

rm -rf target/linux/generic/!(*-5.15) target/linux/rockchip

git_clone_path istoreos-22.03 https://github.com/istoreos/istoreos package/boot target/linux/rockchip

git_clone_path istoreos-22.03 https://github.com/istoreos/istoreos mv target/linux/generic

wget -N https://github.com/istoreos/istoreos/raw/istoreos-22.03/include/kernel-5.10 -P include/

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

mv -f tmp/r8125 feeds/kiddin9/

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/rk35xx.mk
sed -i -e 's,wpad-openssl,wpad-basic-mbedtls,g' target/linux/rockchip/image/rk35xx.mk

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -P package/kernel/linux/modules/

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

cp -Rf $SHELL_FOLDER/diy/* ./

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/rk35xx/config-5.10
