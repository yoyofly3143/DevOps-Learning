#!/bin/bash

# === 检查参数 ===
if [ $# -ne 1 ]; then
    echo "用法: $0 <日志目录>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="$HOME/log_archives"   # 存放压缩文件的目录
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILE="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="$ARCHIVE_DIR/archive.log"

# === 检查日志目录是否存在 ===
if [ ! -d "$LOG_DIR" ]; then
    echo "错误: 日志目录 $LOG_DIR 不存在"
    exit 1
fi

# === 创建归档目录 ===
mkdir -p "$ARCHIVE_DIR"

# === 压缩日志 ===
tar -czf "$ARCHIVE_DIR/$ARCHIVE_FILE" -C "$LOG_DIR" .

if [ $? -eq 0 ]; then
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] 已归档 $LOG_DIR 到 $ARCHIVE_FILE" >> "$LOG_FILE"
    echo "✅ 成功：日志已归档到 $ARCHIVE_DIR/$ARCHIVE_FILE"
else
    echo "❌ 错误：压缩失败"
    exit 1
fi
