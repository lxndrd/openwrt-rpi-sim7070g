OPENWRT_VERSION ?= 24.10.4
IMAGE := "./openwrt-imagebuilder/bin/targets/bcm27xx/bcm2710/openwrt-${OPENWRT_VERSION}-bcm27xx-bcm2710-rpi-3-ext4-factory.img.gz"

build:
	docker build . --build-arg OPENWRT_VERSION=${OPENWRT_VERSION} --output openwrt-imagebuilder/bin
	cp "${IMAGE}" openwrt-rpi.img.gz
	gzip -vdf openwrt-rpi.img.gz

flash:
	sudo dd if=openwrt-rpi.img of=/dev/sdb bs=4M conv=fsync conv=fsync oflag=direct status=progress
	sudo sync

clean:
	rm -rf ./openwrt-*
