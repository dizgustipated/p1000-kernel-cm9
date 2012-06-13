#!/bin/bash


clear

cd ~/androidcm9/system/kernel/samsung/Kernel

make mrproper


DATA=`date '+%Y%m%d' --date="+1 days ago"`
echo $DATA > .version

echo " "
echo " "
echo "================================================================================================================="
echo "  MAKING DEFCONFIG"
echo "================================================================================================================="

#P1000L
#make -j4 ARCH=arm p1_ltn_l_cm9_defconfig

#P1000
make -j4 ARCH=arm p1_cm9_defconfig

##P1000N
#make -j4 ARCH=arm p1_ltn_n_cm9_defconfig

echo "================================================================================================================="
echo "  opening Kernel GUI"
echo "================================================================================================================="

make menuconfig

echo " "
echo " "
echo " "
echo " "

echo "================================================================================================================="
echo "  BUILDING MODULES AND COPYING THEM TO RAMDISK"
echo "================================================================================================================="

make -j8 modules

echo " "
echo " "
find . -iname *.ko | xargs cp -frvt ../initramfs/lib/modules/
/opt/toolchains/arm-2009q3/bin/arm-none-eabi-strip --strip-debug ../initramfs/lib/modules/* 
echo " "
echo " "
echo " "
sleep 2

echo "================================================================================================================="
echo "  BUILDING KERNEL"
echo "================================================================================================================="

make -j8

cd arch/arm/boot
ls -la