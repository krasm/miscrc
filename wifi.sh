#!/bin/sh
iw dev wlp2s0 link | perl -n -e'/SSID:\s+(.+$)/ && print $1'|xargs echo -n -e
