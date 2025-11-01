ARG OPENWRT_VERSION=24.10.4
FROM docker.io/openwrt/imagebuilder:bcm27xx-bcm2710-${OPENWRT_VERSION} AS builder

RUN ./setup.sh

COPY ./files ./files

RUN make image \
    PROFILE="rpi-3" \
    FILES="./files" \
    PACKAGES="picocom usbutils gpiod-tools comgt kmod-usb-net-cdc-ether"

FROM scratch
COPY --from=builder /builder/bin /
