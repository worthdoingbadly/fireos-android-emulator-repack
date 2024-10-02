make -C /lib/modules/`uname -r`/build M=$PWD CC=aarch64-linux-gnu-gcc-12 "$@"
