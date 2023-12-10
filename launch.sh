#!/bin/sh
if [ "$#" -gt 0 ]; then
    img_path="$1";
    echo "$img_path";
    qemu-system-aarch64 \
        -M virt \
        -cpu cortex-a72 \
        -smp 8 \
        -m 128M \
        -kernel ./build/arch/arm64/boot/Image \
        -initrd ./busybox-1.36.1/initramfs.cpio.gz \
        -drive file="$img_path",format=raw,id=disk,if=none \
        -device virtio-blk-device,drive=disk \
        -nographic \
        -append "init=/init console=ttyAMA0"
else
    qemu-system-aarch64 \
        -M virt \
        -cpu cortex-a72 \
        -smp 8 \
        -m 128M \
        -kernel ./build/arch/arm64/boot/Image \
        -initrd ./busybox-1.36.1/initramfs.cpio.gz \
        -nographic \
        -append "init=/init console=ttyAMA0"
fi