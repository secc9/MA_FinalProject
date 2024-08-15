#!/bin/bash



#split into frames

mkdir script04

#take a vidoe

rpicam-vid -t 3s --width 1280 --height 720 --vflip -o script04/vid01.mp4

#split into frames
ffmpeg -i script04/vid01.mp4 -vf "fps=27.33" script04/frames-%02d.png


#saturate
for i in {1..82}
do
	 rn=$((RANDOM % 21 -10))
	 
	 ffmpeg -i script04/frames-$(printf "%02d" $i).png -vf "hue=h=180:s=${rn}" script04/fsat-$(printf "%02d" $i ).png

done
# concat
#ffmpeg -f concat -safe 0 -i script04files.txt -c copy script04/vid03.mp4
ffmpeg -i script04/fsat-%02d.png -r 10 -vf "setpts=4.0*PTS" script04/vid02.mp4


ffplay -i script04/vid02.mp4 -fs -autoexit
#ffplay -i script04/vid03.mp4 -fs -autoexit
#open script04

#sleep 10
rm -rf script04
