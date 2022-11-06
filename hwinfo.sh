#!/bin/bash
CPU_ARCH=`uname -m`

if [[ $CPU_ARCH == *arm* ]] ; then
	CPU_VENDOR="Broadcom"
	CPU_MODEL=`cat /proc/cpuinfo | grep -m1 "Hardware" | sed -e "s/Hardware.*: //"`
	CPU_CLOCK_HZ=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
	CPU_CLOCK=`expr $CPU_CLOCK_HZ / 1024`
else
	CPU_VENDOR=""
	CPU_MODEL=`cat /proc/cpuinfo | grep -m1 "model name" | sed -e "s/model name.*: //"`
	CPU_CLOCK=`cat /proc/cpuinfo | grep "cpu MHz" | sed -e "s/cpu MHz.*: //"`
fi

echo "--- EVA Client information ---"
echo "CPU:" $CPU_VENDOR $CPU_MODEL "@" $CPU_CLOCK"MHz"
uptime | grep -o "load average.*" | sed "s/load average/LoadAvg/g"
cat /proc/meminfo | grep "MemTotal:" | xargs
cat /proc/meminfo | grep "MemFree:" | xargs
date +"CurDate: %H:%M:%S %d.%m.%Y %z"
echo "Uptime:" `uptime | sed -e "s/^\(.*\)*up//;s/,\(.*\)*$"//`
