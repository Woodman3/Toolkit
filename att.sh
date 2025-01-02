#!/bin/bash

# 查找所有进程名为 "virtex" 的 PID
PID=$(ps -C virtex -o pid,stat,comm | awk '$2 ~ /^R/ {print $1}')

# 检查是否找到 PID
if [ -z "$PID" ]; then
    echo "未找到进程名为 'virtex' 的进程。"
    exit 1
fi

echo "找到进程 'virtex' 的 PID: $PID"
gdb -p "$PID" 