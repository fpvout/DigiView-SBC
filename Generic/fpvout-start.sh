#!/bin/bash

export DISPLAY=:0;

cd /home/fpvout/Scripts/fpv-c/

./fpv-video-out | gst-launch-1.0 fdsrc fd=0 ! decodebin ! autovideosink

exit 0
