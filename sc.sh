#!/bin/bash

# 获取最近提交的作业 ID
JOBID=$(squeue -u $USER -h -o "%i" | head -n 1)

# 检查是否找到作业 ID
if [ -z "$JOBID" ]; then
    echo "未找到最近提交的作业。"
    exit 1
fi

# 取消作业
echo "正在取消作业 ID: $JOBID ..."
scancel $JOBID

# 检查是否取消成功
if [ $? -eq 0 ]; then
    echo "作业已成功取消。"
else
    echo "取消作业失败。"
fi