#!/bin/bash

echo "Testing connection to GoPro"
ping 10.5.5.9 -c 3

echo "Starting GoPro LiveStream"
curl "http://10.5.5.9/gp/gpExec?p1=gpStreamA9&c1=restart"

echo "Running GoPro keep alive"
while (true) do echo "_GPHD_:0:0:2:" > /dev/udp/10.5.5.9/8554; sleep 2; done &

echo "Redirecting Video"
sudo ffmpeg -f mpegts -i udp://10.5.5.9:8554 -map 0:0 -c copy -f rtp udp://127.0.0.1:5000 &

echo "Video should now be available in QGroundControl.  Choose UDP Video Stream and port 5000"

