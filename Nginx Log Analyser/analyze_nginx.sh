#!/bin/bash
# 分析 nginx 日志的简单工具
# 日志文件路径
LOG_FILE="nginx.log"

# 确认日志文件是否存在
if [ ! -f "$LOG_FILE" ]; then
    echo "❌ Log file not found: $LOG_FILE"
    exit 1
fi

echo "=== Top 5 IP addresses with the most requests ==="
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

echo "=== Top 5 most requested paths ==="
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

echo "=== Top 5 response status codes ==="
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

echo "=== Top 5 user agents ==="
# 注意：user agent 通常从第 12 列开始（因为它可能有空格）
awk -F\" '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
