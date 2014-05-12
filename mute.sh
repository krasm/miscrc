#!/usr/bin/zsh

STATUS=`amixer get Master | awk '/Mono:/ {if($6 == "[on]") {print "unmuted"} else {print "muted"}}'`

if [[ $STATUS == "unmuted" ]] ;
then 
	amixer set Master mute 
else 
	amixer set Master unmute
fi
