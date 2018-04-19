# gopro-stream-docker by James Trimble <rkh932@mocs.utc.edu>
#  Sets up WiFi streaming from a GoPro to QGroundControl.
#  The host machine should already be connected to the GoPro via WiFi 
#  and should be running QGroundControl.

LABEL maintainer="rkh932@mocs.utc.edu"

FROM ubuntu

# Install ffplay,ffmpeg,curl
RUN apt-get update && apt-get install -y ffmpeg curl

# Add the script which will automatically setup the streaming processes
ADD ./goGPQGC.sh ~

# Expose the required ports
EXPOSE 8554/udp # Port for incoming GoPro Video Stream
EXPOSE 8080/tcp # Port for GoPro REST API (Control)
EXPOSE 5000/udp # Port that video will be pushed to QGroundControl on

# Setup the script to run automatically when the container is launched
CMD ["source ~/goGPQGC.sh",""]
