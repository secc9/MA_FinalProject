#!/bin/bash

#take a video
#process it some how#
#crop and scale


#make a dir
mkdir script02

# take a video
rpicam-vid  -t 3s --width 1280 --height 720 --vflip --saturation 2.0  -o script02/vid01.mp4

#crop
ffmpeg -i script02/vid01.mp4 -vf "scale=1280x720, crop=500:500:500:500"  script02/vid02.mp4

#play vanilla video
ffplay -i script02/vid02.mp4 -fs -autoexit

#crop
ffmpeg -i script02/vid02.mp4 -vf "scale=1280x720, crop=500:500:500:500"  script02/vid03.mp4

#play vanilla video
ffplay -i script02/vid03.mp4 -fs -autoexit

#crop
ffmpeg -i script02/vid03.mp4 -vf "scale=1280x720, crop=500:500:500:500"  script02/vid04.mp4

#play vanilla video
ffplay -i script02/vid04.mp4 -fs -autoexit

#crop
ffmpeg -i script02/vid04.mp4 -vf "scale=1280x720,crop=500:500:500:500 "  script02/vid05.mp4

#play vanilla video
ffplay -i script02/vid05.mp4 -fs -autoexit

#crop
ffmpeg -i script02/vid05.mp4 -vf "scale=1280x720,crop=500:500:500:500"  script02/vid06.mp4

#play vanilla video
ffplay -i script02/vid06.mp4 -fs -autoexit







#open script02
#sleep 5
rm -rf script02
