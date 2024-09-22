../lpunpack_and_lpmake/bin/lpmake \
	--device-size=$((4*1024*1024*1024)) \
	--metadata-size=$((64*1024)) \
	--metadata-slots=2 \
	--group=emulator_dynamic_partitions:$(((4*1024*1024*1024) - (64*1024))) \
	--partition=system:readonly:$(stat -c "%s" ../amazon/system_carved.img):emulator_dynamic_partitions \
	--partition=system_ext:readonly:$(stat -c "%s" ../amazon/system_ext_carved.img):emulator_dynamic_partitions \
	--partition=product:readonly:$(stat -c "%s" ../amazon/product_carved.img):emulator_dynamic_partitions \
	--partition=vendor:readonly:$(stat -c "%s" vendor_original_system.img):emulator_dynamic_partitions \
	--image=system=../amazon/system_carved.img \
	--image=system_ext=../amazon/system_ext_carved.img \
	--image=product=../amazon/product_carved.img \
	--image=vendor=vendor_original_system.img \
	--output=repacked_super.img

