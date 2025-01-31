#!/bin/bash

#negate
mkdir s07


rpicam-vid -t 5s --width 1280 --height 720 --vflip --brightness 0.2 -o s07/vid1.mp4


ffmpeg -i s07/vid1.mp4 -vf "noise=alls=20:allf=t+u, negate" s07/vid2.mp4

ffplay -fs -i s07/vid2.mp4 -autoexit



rm -rf s07
