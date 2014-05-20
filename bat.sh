#!/bin/sh

wifi=`/sbin/iwlist wlan0 scanning| grep ESSID: | tr -s '"' ' ' | cut -d ' ' -f3`
info=`acpi | tr -s , ' ' | cut -d ' '  -f3` 
stat=`acpi | tr -s , ' ' | cut -d ' '  -f4` 
temp=`acpi -t | tr -s , ' ' | cut -d ' ' -f4 | sort -nr | head -n1`
pct=`acpi | tr -s , ' ' | cut -d  ' ' -f5`
color="\005{..g}"

case $info in
    Discharging) color="\005{..r}" ;;
esac

result=""
if [ "x" != "x"$wifi ] ; then 
	result="$result [$wifi]"
fi
result="$result[$color$stat \005{..d}$temp"

result="$result]"

echo -e $result
