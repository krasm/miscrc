#!/bin/sh
iw dev wlp3s0 link | perl -n -e'/SSID:\s+(.+$)/ && print $1'|xargs echo -n -e
