#Script pack and unpack 

#!/bin/bash

read -p "Type 'unpack' to unpack or' pack' to pack: " var1
if [ $var1 = unpack ];
then
mkdir -p unpack
tools/unpackbootimg -i boot.img -o unpack
mkdir -p unpack/boot.img-ramdisk
cd unpack/boot.img-ramdisk
gzip -dc ../boot.img-ramdisk.gz | cpio -i
cd ../../
fi
if [ $var1 = pack ];
then
tools/mkbootfs unpack/boot.img-ramdisk | gzip > unpack/boot.img-ramdisk.gz
tools/mkbootimg --kernel unpack/boot.img-zImage --ramdisk unpack/boot.img-ramdisk.gz -o boot.img-repack --base `cat unpack/boot.img-base`
fi
