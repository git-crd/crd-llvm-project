#!/bin/bash

# 检查是否为root权限
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要root权限运行，请使用sudo执行"
    exit 1
fi

echo "当前内存使用情况："
free -h

echo -e "\n开始清理内存缓存..."

# 清理页面缓存、目录项和inode
sync
echo 3 > /proc/sys/vm/drop_caches

# 如果有交换空间，也尝试清理
if [ -f /proc/swaps ] && [ "$(wc -l < /proc/swaps)" -gt 1 ]; then
    echo "清理交换空间..."
    swapoff -a
    swapon -a
fi

echo -e "\n清理完成后的内存使用情况："
free -h