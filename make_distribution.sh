#!/bin/sh
echo "ANDROID_INSTALL_DIRECTORY is $1 and TARGET_PRODUCT_NAME is $2"

ANDROID_INSTALL_DIRECTORY=$1
TARGET_PRODUCT_NAME=$2
DISTRIBUTION_PATH=$ANDROID_INSTALL_DIRECTORY/out/target/product/$TARGET_PRODUCT_NAME/$TARGET_PRODUCT_NAME
#make TARGET_PRODUCT=$TARGET_PRODUCT_NAME OMAPES=4.x
#make TARGET_PRODUCT=$TARGET_PRODUCT_NAME OMAPES=4.x u-boot_build
#make TARGET_PRODUCT=$TARGET_PRODUCT_NAME OMAPES=4.x fs_tarball

if [ -d $DISTRIBUTION_PATH ]; then
	echo "Prebuilt image for $TARGET_PRODUCT_NAME already exists!"
	rm -rf $DISTRIBUTION_PATH
fi

echo "Creating new prebuilt image"

mkdir $DISTRIBUTION_PATH
mkdir $DISTRIBUTION_PATH/Boot_Images
mkdir $DISTRIBUTION_PATH/Boot_Images/dtbs
mkdir $DISTRIBUTION_PATH/Filesystem
mkdir $DISTRIBUTION_PATH/Media_Clips
cp $ANDROID_INSTALL_DIRECTORY/u-boot/MLO $DISTRIBUTION_PATH/Boot_Images
cp $ANDROID_INSTALL_DIRECTORY/u-boot/u-boot.img $DISTRIBUTION_PATH/Boot_Images
cp $ANDROID_INSTALL_DIRECTORY/kernel/arch/arm/boot/zImage $DISTRIBUTION_PATH/Boot_Images
cp $ANDROID_INSTALL_DIRECTORY/kernel/arch/arm/boot/dts/am335x-boneblack.dtb $DISTRIBUTION_PATH/Boot_Images/dtbs
cp $ANDROID_INSTALL_DIRECTORY/kernel/arch/arm/boot/dts/am335x-bonegreen.dtb $DISTRIBUTION_PATH/Boot_Images/dtbs
cp $ANDROID_INSTALL_DIRECTORY/external/ti_android_utilities/am335x/u-boot-env/uEnv_$TARGET_PRODUCT_NAME.txt $DISTRIBUTION_PATH/Boot_Images/uEnv.txt
cp $ANDROID_INSTALL_DIRECTORY/out/target/product/$TARGET_PRODUCT_NAME/rootfs.tar.bz2 $DISTRIBUTION_PATH/Filesystem
cp -r $ANDROID_INSTALL_DIRECTORY/external/ti_android_utilities/Media_Clips $DISTRIBUTION_PATH/
cp $ANDROID_INSTALL_DIRECTORY/external/ti_android_utilities/am335x/mk-mmc/* $DISTRIBUTION_PATH/

