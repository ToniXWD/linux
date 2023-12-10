#!/bin/sh

cp -r ./build/samples/rust/*.ko ./busybox-1.36.1/_install/rust/
cd busybox-1.36.1/_install/

# 文件名
FILENAME="init"

# 检查文件是否存在
if [ ! -f "$FILENAME" ]; then
    # 文件不存在，创建文件并写入内容
    cat > "$FILENAME" << 'EOF'
#!/bin/sh

# 挂载一些必要的文件系统
mount -t proc none /proc
mount -t sysfs none /sys
mount -t tmpfs none /tmp
mount -t devtmpfs none /dev

# 停留在控制台
exec /bin/sh
EOF
    # 使脚本可执行
    chmod +x "$FILENAME"
    echo "文件 '$FILENAME' 已创建并设置为可执行。"
else
    echo "文件 '$FILENAME' 已存在。"
fi


find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz
