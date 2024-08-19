#!/bin/bash

#grid

#mak a dir
mkdir script05

#take a vid
rpicam-vid  --width 1280 --height 720 --vflip -o script05/vid01.mp4


# gridded image

ffmpeg -i script05/vid01.mp4 -vf "crop=iw/2:ih/2:0:0" script05/crop-0.mp4      #top-left
ffmpeg -i script05/vid01.mp4 -vf "crop=iw/2:ih/2:iw/2:0" script05/crop-1.mp4  #top-right
ffmpeg -i script05/vid01.mp4 -vf "crop=iw/2:ih/2:0:ih/2" script05/crop-2.mp4     #bottom-left
ffmpeg -i script05/vid01.mp4 -vf "crop=iw/2:ih/2:iw/2:ih/2" script05/crop-3.mp4     #bottom-right



ffmpeg  -i script05/crop-0.mp4 -vf "transpose=1, transpose=1, hue=s=10" script05/crop-0-rotate.mp4 -y
ffmpeg  -i script05/crop-1.mp4 -vf "transpose=0, transpose=1, hue=h=90:s=5" script05/crop-1-rotate.mp4 -y
ffmpeg  -i script05/crop-2.mp4 -vf "transpose=1, transpose=0, hue=h=-180:s=7" script05/crop-2-rotate.mp4 -y



ffmpeg -i script05/crop-0-rotate.mp4 -i script05/crop-1-rotate.mp4 -i script05/crop-2-rotate.mp4 -i script05/crop-3.mp4 \
       -filter_complex \
       "[1:v][0:v]hstack=inputs=2[top];\
	[3:v][2:v]hstack=inputs=2[bottom];\
	[top][bottom]vstack=inputs=2[v]"\
       -map "[v]" \
      script05/grid-2x2.mp4





ffmpeg  -i script05/vid01.mp4 -vf "setpts=4*PTS" script05/rotate01.mp4


ffplay -i script05/grid-2x2.mp4 -fs -autoexit

sleep 5

rm -rf script05

