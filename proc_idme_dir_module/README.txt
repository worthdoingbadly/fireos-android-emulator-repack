git clone https://android.googlesource.com/kernel/common
git checkout 212a7aaded26d928452b1d4bc1c756fb3bfbf782
pull /prod/config.gz from emulator
put it into arm64/configs/goldfish_defconfig
comment out:
- CONFIG_TRIM_UNUSED_KSYMS
- CONFIG_UNUSED_KSYMS_WHITELIST
make goldfish_defconfig LLVM=1
make -j8 LLVM=1

insmod /data/local/tmp/proc_idme_dir.ko
mkdir /data/local/tmp/idme
mount -o ro,bind /data/local/tmp/idme /proc/idme

idme files needed for getNewDeviceCredentials call:
- /proc/idme/mac_sec
- /proc/idme/mac_addr

See
https://trepo.tuni.fi/bitstream/handle/123456789/22617/Nurmi.pdf
https://xdaforums.com/t/unlock-root-twrp-unbrick-firetv-2-sloane.4222331/page-26#post-86017275
