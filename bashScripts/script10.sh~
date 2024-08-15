#!/bin/bash


#hue sat cycle

mkdir s09

rpicam-vid -t 7s --width 1280 --height 720 --vflip -o s09/vid1.mp4


ffmpeg -i s09/vid1.mp4 -vf "hue=h=t*90:s=t*180" s09/vid2.mp4


ffplay -i s09/vid2.mp4 -fs -autoexit

rm -rf s09/vid2.mp4
