#!/bin/bash

export DISPLAY=:0;

cd /home/fpvout/Scripts/fpv-c/

./fpv-video-out | gst-launch-1.0 -v fdsrc ! h264parse ! omxh264dec full-frame=true disable-dpb=true enable-error-check=true enable-low-outbuffer=true ! nvoverlaysink sync=false

exit 0
