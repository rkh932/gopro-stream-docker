# gopro-stream-docker by James Trimble <rkh932@mocs.utc.edu>
#  Sets up WiFi streaming from a GoPro to QGroundControl.
#  The host machine should already be connected to the GoPro via WiFi 
#  and should be running QGroundControl.
FROM ubuntu

LABEL maintainer="rkh932@mocs.utc.edu"

# Install ffplay,ffmpeg,curl
RUN apt-get update && apt-get install -y ffmpeg curl iputils-ping nano iproute2 net-tools

# Add the script which will automatically setup the streaming processes
ADD ./goGPQGC.sh /home/goGPQGC.sh

# Expose the required ports
# Port for incoming GoPro Video Stream
EXPOSE 8554/udp 

# Port for GoPro REST API (Control)
EXPOSE 80/tcp 

# Port that video will be pushed to QGroundControl on
EXPOSE 5000/udp 

# Setup the script to run automatically when the container is launched
RUN chmod 555 /home/goGPQGC.sh
CMD /home/goGPQGC.sh

