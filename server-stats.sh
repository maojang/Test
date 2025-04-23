#!/bin/bash

echo "===== Server Performance Stats ====="
echo ""

# CPU Usage
echo "1. CPU Usage:"
top -l 1 -s 0 -n 5 | grep "CPU usage" | awk '{print "User: " $3 ", System: " $5 ", Idle: " $7}'
echo ""

# Memory Usage
echo "2. Memory Usage:"
vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f MB\n", "$1:", $2 * $size / 1048576)'
echo ""

# Disk Usage
echo "3. Disk Usage:"
df -h | grep -E 'Filesystem|disk1s' | awk '{print $1 ": " $3 " used, " $4 " free"}'
echo ""

# Top 5 Processes by CPU
echo "4. Top 5 Processes by CPU:"
ps -erco %cpu,comm | head -n 6
echo ""

# Top 5 Processes by Memory
echo "5. Top 5 Processes by Memory:"
ps -ercmo %mem,comm | head -n 6
echo ""