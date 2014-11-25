#!/bin/sh

/sbin/iw dev  wlan0 link |  sed  -n 's/SSID:\s*\(.\+\)\s*/\1/p' | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//'
