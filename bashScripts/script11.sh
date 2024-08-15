#!/bin/bash


#hrotate

mkdir s11

rpicam-vid -t 7s --width 1280 --height 720 --vflip -o s11/vid1.mp4


ffmpeg -i s11/vid1.mp4 -vf "rotate='2*PI*t:ow=min(iw,ih)/sqrt(4)+1:oh=ow'" s11/vid2.mp4


ffplay -i s11/vid2.mp4 -fs -autoexit

rm -rf s11
