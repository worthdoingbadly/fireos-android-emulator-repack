#!/bin/sh
# super partition starts at 4096*512 = 2097152 bytes
# start = 2048 size = 1563120

dd if=system.img bs=512 skip=$((4096+2048)) count=1563120 of=system_original_system.img
