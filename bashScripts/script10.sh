#!/bin/bash


#hue sat cycle

mkdir s10

rpicam-vid -t 7s --width 1280 --height 720 --vflip -o s10/vid1.mp4


ffmpeg -i s10/vid1.mp4 -vf "hue=h=t*90:s=t*180" s10/vid2.mp4
ffmpeg -i s10/vid2.mp4 -vf "hue=h=t*180:s=t*360,pixelize=w=100:h=102:m=max:p=10:enable='between(t,0,1)', pixelize=w=200:h=200:m=max:p=20:enable='between(t,2,3)', pixelize=w=300:h=300:m=max:p=40:enable='between(t,3,4)', pixelize=w=500:h=500:m=max:p=60:enable='between(t,4,5)', pixelize=w=700:h=700:m=max:p=100:enable='between(t,5,6)', pixelize=w=1000:h=1000:m=max:p=120:enable='between(t,6,7)'" s10/vid3.mp4
ffplay -i s10/vid3.mp4 -fs -autoexit

rm -rf s10
