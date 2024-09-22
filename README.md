Scripts to repack a Fire OS factory image from the Amazon Fire HD10 13th Gen (tungsten) to boot in Android Emulator (on an Apple Silicon Mac)

https://notnow.dev/notice/AmFQTImYZgWEPvBV7w

This is useless for you, probably. I'm just documenting this for myself.

You need:
- https://github.com/danielmmmm/dat2img
- https://github.com/LonelyFool/lpunpack_and_lpmake
- Android 11, "System Image arm64-v8a with Google APIs." Revision=16
- Update file from https://www.amazon.com/update_Fire_HD10_13th_Gen (https://fireos-tablet-src.s3.us-west-2.amazonaws.com/M7nrtAEBjfuFrO76zt0kqEdQ73/update-kindle-Fire_HD10_13th_Gen-RS8324_user_2314_0023153150596.bin)

dat2img the OTA into a system.img

put Fire OS system.img into amazon/

put emulator system.img into avd/

Run this on Ubuntu:

```
cd amazon
sudo mount -o ro,loop system.img tempmnt
```

```
cd avd
bash pull_system_from_super.sh
bash pull_vendor_from_super.sh
bash pull_vbmeta_from_super.sh
sudo mount -o ro,loop system_original_system.img tempmnt
```

To build the image:

```
cd amazon
sudo bash carve_into_partitions.sh
cd ../avd
bash make_new_super.sh && bash construct_full_system_image.sh
```

Run this on the Mac:

```
echo get avd/output_system.img system.img | sftp ruby.local
```

```
~/Library/Android/sdk/emulator/emulator -avd Pixel_8_Pro_API_30 -show-kernel -sysdir /Volumes/orangehd/docs/amazon/emulator_with_new_image_hd10/ -selinux permissive -accel on
```

optionally, `-android-serialno <serial number>`

On first boot, setup will hang, do

```
adb root
adb shell stop
adb shell start
```

