#!/bin/sh
set -e
rm -rf system_carved.img system_ext_carved.img product_carved.img system_carved system_ext_carved product_carved || true
mkdir system_carved
mkdir system_ext_carved
mkdir product_carved
truncate -s 1300M system_carved.img
mke2fs system_carved.img
truncate -s 2400M system_ext_carved.img
mke2fs system_ext_carved.img
truncate -s 50M product_carved.img
mke2fs product_carved.img
mount -o rw,loop system_carved.img system_carved
mount -o rw,loop system_ext_carved.img system_ext_carved
mount -o rw,loop product_carved.img product_carved
rsync -aAX --exclude=/system/system_ext --exclude=/system/product tempmnt/ system_carved/
rm system_carved/product system_carved/system_ext
# TODO(zhuowei): SELinux?
mkdir system_carved/product
mkdir system_carved/system_ext
ln -s /product system_carved/system/product
ln -s /system_ext system_carved/system/system_ext
sed -i \
	-e "s/^ro.product.cpu.abilist=arm64-v8a,armeabi-v7a,armeabi$/ro.product.cpu.abilist=arm64-v8a/" \
	-e "s/^ro.product.cpu.abilist32=armeabi-v7a,armeabi/ro.product.cpu.abilist32=/" \
	system_carved/system/build.prop
#for i in cameraserver drmserver mediaserver;
#do
#	rsync -aAX ../avd/tempmnt/system/bin/$i system_carved/system/bin/$i
#done
rsync -aAX ../avd/tempmnt/system/xbin/su system_carved/system/xbin/su
# permissive SELinux needs userdebug init
rsync -aAX ../avd/tempmnt/system/bin/init system_carved/system/bin/init
rsync -aAX ../avd/tempmnt/system/etc/init/hw/init.zygote64.rc system_carved/system/etc/init/hw/init.zygote64.rc
cp init.ranchu.rc system_carved/
chown 0:0 system_carved/init.ranchu.rc
chmod 644 system_carved/init.ranchu.rc
rsync -aAX tempmnt/system/system_ext/ system_ext_carved/
rsync -aAX tempmnt/system/product/ product_carved/
# emulator's vendor sets ro.apex.updatable to true; our system doesn't have any apex, so we need to override it back
# set property_source_order to force the model numbers from system/build.prop (odm and vendor has Google/emulator models)
# set ro.product.model manually since on real device it's set in init.mt8169.rc
echo "ro.apex.updatable=false
ro.debuggable=1
ro.product.property_source_order=product,system
ro.product.product.model=KFTUWI
ro.product.config.type=A2V9UEGZ82H4KZ" >> product_carved/build.prop
umount system_carved
umount system_ext_carved
umount product_carved
