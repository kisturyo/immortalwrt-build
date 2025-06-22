#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Remove zh-cn language default
sed -i 's/luci-i18n-ksmbd-zh-cn//' target/linux/mediatek/image/mt7981.mk
sed -i 's/luci-i18n-usb-printer-zh-cn//' target/linux/mediatek/image/mt7981.mk
sed -i 's/luci-i18n-ksmbd-zh-cn//' target/linux/mediatek/image/mt7986.mk
sed -i 's/luci-i18n-usb-printer-zh-cn//' target/linux/mediatek/image/mt7986.mk

# Add additional package
mkdir package/additional
git clone https://github.com/kiddin9/luci-theme-edge.git package/additional/luci-theme-edge

# Add a feed source
echo "src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main" >> "feeds.conf.default"

# Remove kernel version's MD5
sed -i 's/~$(LINUX_VERMAGIC)-/-/g' include/kernel.mk
sed -i 's/~$(LINUX_VERMAGIC)-/-/g' package/kernel/linux/Makefile

# Add compilation date in OpenWrt firmware version
date=`date +%Y.%m.%d`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk