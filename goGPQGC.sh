#!/bin/bash

echo "Testing connection to GoPro"
ping 10.5.5.9 -c 1
sleep 2

echo "Starting GoPro LiveStream"
curl "http://10.5.5.9/gp/gpExec?p1=gpStreamA9&c1=restart" >/dev/null
curl "http://10.5.5.9:8080/gp/gpControl/execute?p1=gpStream&c1=restart" >/dev/null
sleep 1

echo "Set LCD and Power Settings"
# Auto Off: Never
curl "http://10.5.5.9/gp/gpControl/setting/59/0" >/dev/null
# OSD: Off
curl "http://10.5.5.9/gp/gpControl/setting/58/0" >/dev/null
# LED Blink: Off
curl "http://10.5.5.9/gp/gpControl/setting/55/0" >/dev/null
# LCD Timeout: 1 min
curl "http://10.5.5.9/gp/gpControl/setting/51/1" >/dev/null

echo "Running GoPro keep alive"
while (true) do echo "_GPHD_:0:0:2:" > /dev/udp/10.5.5.9/8554; sleep 2; done & >/dev/null

echo "Redirecting Video"
ffmpeg -fflags nobuffer -f mpegts -i udp://10.5.5.9:8554 -map 0:0 -c copy -f rtp udp://127.0.0.1:5000 & >/dev/null
sleep 2

echo "Video should now be available in QGroundControl.  Choose UDP Video Stream and port 5000"

sleep infinity
