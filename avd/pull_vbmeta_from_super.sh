#!/bin/sh
: """
$ sgdisk -p system.img
Disk system.img: 6313984 sectors, 3.0 GiB
Sector size (logical): 512 bytes
Disk identifier (GUID): F3D9BFDC-393A-4A80-A0DB-8384689F871B
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 6313950
Partitions will be aligned on 2048-sector boundaries
Total free space is 4029 sectors (2.0 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048            4095   1024.0 KiB  8300  vbmeta
   2            4096         6311935   3.0 GiB     8300  super
"""
dd if=system.img bs=512 skip=2048 count=$((4096-2048)) of=vbmeta_original_system.img
