#!/bin/sh
# super, vbmeta, 1MB extra for partition table
set -e
rm output_system.img || true
truncate -s $(((4*1024*1024*1024) + (1*1024*1024) + (1*1024*1024))) output_system.img
sgdisk -n 1:2048:4095 output_system.img
sgdisk -n 2:4096:0 output_system.img
sgdisk -c 1:vbmeta output_system.img
sgdisk -c 2:super output_system.img
sgdisk -p output_system.img
dd if=vbmeta_original_system.img bs=512 seek=2048 conv=notrunc of=output_system.img
dd if=repacked_super.img bs=1M seek=$((4096*512)) conv=notrunc of=output_system.img oflag=seek_bytes
#dd if=repacked_super.img bs=512 seek=$((4096 + (4096 / 512))) conv=notrunc of=output_system.img
#dd if=../amazon/system.img bs=$((512*2048)) seek=$(((4096 + 2048) / 2048)) conv=notrunc of=output_system.img
#dd if=vendor_original_system.img bs=$((512*2048)) seek=$(((4096 + 6946816) / 2048)) conv=notrunc of=output_system.img
