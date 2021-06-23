#!/bin/bash 

export DISPLAY=:0;

cd /home/fpvout/Scripts/fpv-c/ 

# If there is no display connected don't start streaming with fpv-video-out.
# At best it's a waste of resources, at worst it will prevent the WiFi 
# stream from obtaining the USB connection.
#
# NOTE This is pretty poorly tested (and understood by me). I don't even
#      have an HDMI cable for this PI right now, so I can't test the case
#      where the display is available. I also suspect that this wouldn't 
#      work with composite video out, which is a pretty valid use case
#      for using an old analog monitor (like the one sitting in my garage).
#      I could probably embed a PI zero inside of that display and get a
#      high quality but low res stream for passengers.
displayStatus=$(/usr/bin/tvservice -s)
displayDetect="[TV is off]"
if [[ "$displayStatus" ==  *"$displayStatus"* ]]; then
    echo "No HDMI display connected, not streaming to screen. $displayStatus"
else
    echo "HDMI display detected, streaming to screen. $displayStatus"
    ./fpv-video-out | /opt/vc/src/hello_pi/hello_video/hello_video.bin
fi
