#!/bin/bash

echo "====================== Server Performance Stats ======================"

# 1. Total CPU usage
echo -e "\n--- Total CPU Usage ---"
# 使用 top 的 batch 模式，取 CPU usage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "scale=2; 100 - $cpu_idle" | bc)
echo "Total CPU Usage: $cpu_usage %"

# 2. Total memory usage
echo -e "\n--- Total Memory Usage ---"
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_percent=$(awk "BEGIN {printf \"%.2f\", $mem_used/$mem_total*100}")
echo "Total Memory: ${mem_total}MB"
echo "Used Memory: ${mem_used}MB"
echo "Free Memory: ${mem_free}MB"
echo "Memory Usage: ${mem_percent} %"

# 3. Total disk usage
echo -e "\n--- Total Disk Usage ---"
df -h --total | awk '/^total/ {print "Total Disk: "$2"\nUsed: "$3"\nFree: "$4"\nUsage: "$5}'

# 4. Top 5 processes by CPU usage
echo -e "\n--- Top 5 Processes by CPU Usage ---"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# 5. Top 5 processes by Memory usage
echo -e "\n--- Top 5 Processes by Memory Usage ---"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6

echo "======================================================================="
