#!/bin/bash

echo "Testing connection to GoPro"
ping 10.5.5.9 -c 1
sleep 2

echo "Starting GoPro LiveStream"
curl "http://10.5.5.9/gp/gpExec?p1=gpStreamA9&c1=restart" >/dev/null
sleep 1

echo "Running GoPro keep alive"
while (true) do echo "_GPHD_:0:0:2:" > /dev/udp/10.5.5.9/8554; sleep 2; done & >/dev/null

echo "Redirecting Video"
ffmpeg -f mpegts -i udp://10.5.5.9:8554 -map 0:0 -c copy -f rtp udp://127.0.0.1:5000 & >/dev/null
sleep 2

echo "Video should now be available in QGroundControl.  Choose UDP Video Stream and port 5000"

sleep infinity
