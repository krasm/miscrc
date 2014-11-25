#!/bin/sh

STATE=`cat /proc/acpi/battery/BAT0/state | sed -n 's/charging state:\s*\(.\+\)\s*/\1/p'`
CAPACITY=`cat /proc/acpi/battery/BAT0/info | sed -n 's/design capacity:\s*\([0-9]\+\)\(.\+\)/\1/p'`
CURRENT=`cat /proc/acpi/battery/BAT0/state | sed -n 's/remaining capacity:\s*\([0-9]\+\)\(.\+\)/\1/p'`

if [ $STATE = 'discharging' ] ; then 
    echo -n '-'
elif [ $STATE = 'charging' ] ; then
    echo -n '+'
fi

echo `dc -e "2 k $CURRENT $CAPACITY / 100 * p"`

