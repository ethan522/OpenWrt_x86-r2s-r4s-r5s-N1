#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-5.15

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/64/config-5.15 -P target/linux/x86/64/

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-usb-hid kmod-mmc kmod-sdhci usbutils pciutils lm-sensors-detect kmod-alx kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-i915 kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/kiddin9/

sed -i 's/256/1024/g' target/linux/x86/image/Makefile

echo '
CONFIG_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_NR_CPUS=512
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_DRM_I915=y
# Chelsio
CONFIG_IPV6=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_TLS=y
CONFIG_TLS_TOE=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_INET_ESP_OFFLOAD=y
CONFIG_INET6_ESP_OFFLOAD=y
CONFIG_PCI=y
CONFIG_MDIO=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_DCB=y
CONFIG_FCOE=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_CHELSIO_IPSEC_INLINE=y
CONFIG_CHELSIO_LIB=y
CONFIG_CHELSIO_T4=y
CONFIG_CHELSIO_T4VF=y
CONFIG_CHELSIO_TLS_DEVICE=y
CONFIG_CRYPTO_DEV_CHELSIO=y
CONFIG_CRYPTO_DEV_CHELSIO_TLS=y
CONFIG_SCSI_CXGB4_ISCSI=y
CONFIG_ISCSI_TARGET_CXGB4=y
CONFIG_SCSI_CHELSIO_FCOE=y
' >> ./target/linux/x86/config-5.15

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

