#!/bin/sh
wifi=`/sbin/iwlist wlan0 scanning| grep ESSID: | tr -s '"' ' ' | cut -d ' ' -f3`
info=`acpi | tr -s , ' ' | cut -d ' '  -f3` 
stat=`acpi | tr -s , ' ' | cut -d ' '  -f4` 
temp=`acpi -t | tr -s , ' ' | cut -d ' ' -f4 | sort -nr | head -n1`
pct=`acpi | tr -s , ' ' | cut -d  ' ' -f5`
color="%{k.}"
case $info in
    Discharging) color="\005{r}" ;;
    Charging) color="\005{g}" ;;
esac

echo "[$wifi][$color$stat\005{-} $temp]"
