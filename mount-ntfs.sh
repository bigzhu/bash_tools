#!/bin/bash

# NTFS 移动硬盘挂载脚本
# 使用方法：sudo ./mount-ntfs.sh
# 或者：sudo bash /Users/bigzhu/Sync/Projects/bash_tools/mount-ntfs.sh

VOLUME_NAME="B14T"
MOUNT_POINT="/Volumes/$VOLUME_NAME"

echo "🔍 正在查找 NTFS 移动硬盘..."

# 查找设备名
DEVICE=$(diskutil list | grep "$VOLUME_NAME" | awk '{print $NF}')

if [ -z "$DEVICE" ]; then
    echo "❌ 错误：未找到名为 $VOLUME_NAME 的移动硬盘"
    echo "请检查硬盘是否已连接，或修改脚本中的 VOLUME_NAME 变量"
    exit 1
fi

echo "✅ 找到设备：$DEVICE"
echo "🔄 正在卸载现有挂载..."

# 卸载系统自动挂载的只读分区
sudo umount "$MOUNT_POINT" 2>/dev/null

echo "📁 正在创建挂载点..."
sudo mkdir -p "$MOUNT_POINT"

echo "🔧 正在用 ntfs-3g 挂载为可写模式..."
sudo /opt/homebrew/bin/ntfs-3g -o local,allow_other,default_permissions "/dev/$DEVICE" "$MOUNT_POINT"

if [ $? -eq 0 ]; then
    echo "✅ 挂载成功！"
    echo "📍 挂载点：$MOUNT_POINT"
    echo "💾 现在可以正常写入文件了"
    echo ""
    echo "💡 提示："
    echo "   - 在 Finder 中查看：打开 Finder，按 Cmd+Shift+G，输入 $MOUNT_POINT"
    echo "   - 在终端中访问：cd $MOUNT_POINT"
else
    echo "❌ 挂载失败，请检查设备状态"
    echo "💡 可能的原因："
    echo "   - 设备正在被其他程序使用"
    echo "   - ntfs-3g 未正确安装"
    echo "   - 权限不足"
fi 