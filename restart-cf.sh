#!/bin/bash

# 无限循环
while true; do
    # 获取当前时间
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # 关闭所有匹配条件的 screen 会话
    echo "[$timestamp] Closing detached screen sessions..."
    screen -ls | grep Detached | grep cf | awk -F '[.]' '{print $1}' | xargs -I {} screen -S {} -X quit

    # 启动新的 screen 会话并执行指定命令
    echo "[$timestamp] Starting new screen session for cf..."
    screen -dmS cf bash -c 'cd ~/cf-clearance-scraper && npm start'

    # 等待10分钟
    echo "[$timestamp] Waiting for 30 minutes..."
    sleep 600

    # 更新时间戳
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] Cycle completed. Restarting process..."
done
