#!/bin/bash

export DISPLAY=:0;

cd /home/fpvout/Scripts/fpv-c/

./fpv-video-out | /opt/vc/src/hello_pi/hello_video/hello_video.bin

exit 0
