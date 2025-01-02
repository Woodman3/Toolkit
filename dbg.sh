#!/bin/bash

# 提交作业并获取 JOBID

JOBID=$(sbatch sub.sh | awk '{print $4}')
if [ -z "$JOBID" ]; then
    echo "提交作业失败。"
    exit 1
fi
echo "已提交作业，JOBID: $JOBID"

# 初始化计时器
START_TIME=$(date +%s)
echo "等待分配节点..."
# 等待作业分配到节点
while true; do
    # 获取作业的节点信息
    NODELIST=$(squeue -j $JOBID -h -o "%N")
    
    # 检查是否分配到节点
    if [[ -n "$NODELIST" && "$NODELIST" != "N/A" ]]; then
        echo "作业已分配到节点: $NODELIST"
        break
    fi
    # 计算已等待的时间
    CURRENT_TIME=$(date +%s)
    ELAPSED_TIME=$((CURRENT_TIME - START_TIME))
    printf "已等待: %02d:%02d\r" $((ELAPSED_TIME/60)) $((ELAPSED_TIME%60))

    # 等待 5 秒后重试
    sleep 2
done
# 从节点列表中选择第一个节点
# 处理节点范围格式（如 cn[6148-6151]）
if [[ "$NODELIST" == *"["* ]]; then
    FIRST_NODE=$(echo "$NODELIST" | sed 's/\[.*//')$(echo "$NODELIST" | sed 's/.*\[\([0-9]\+\).*/\1/')
else
    FIRST_NODE=$(echo "$NODELIST" | cut -d',' -f1)
fi
# 直接使用ssh会报 Bad remote protocol version identification: 'SSH-NSS-YHPC-SSHD-WRAPPER' 原因未知
# ssh $NODELIST
bash -i -c "ssh $FIRST_NODE"