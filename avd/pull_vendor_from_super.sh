#!/bin/sh
# super partition starts at 4096*512 = 2097152 bytes
# vendor partition starts at (super + 4575232*4096) = 2097152 + 2342518784 = 0x8bc00000

dd if=system.img bs=512 skip=$((4096 + 4575232)) count=168656 of=vendor_original_system.img
