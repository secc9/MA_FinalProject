#!/bin/bash


# take a video
#stutter the frames

#make a dir
mkdir script03


#take a vide0
rpicam-vid -t 5s --width 1280 --height 720 --vflip --hflip --brightness 0.2 -o script03/vid01.mp4

r_n=$((RANDOM % 11 - 10))
rn=$((RANDOM % 10))
rnu=$((RANDOM % 500))
#stutter frames
ffmpeg -i script03/vid01.mp4 -vf "hue=s=$r_n:b=-2, random=frames=30:seed=$rn"  -pix_fmt yuv420p script03/vid02.mp4

#play
ffplay -i script03/vid02.mp4 -fs -autoexit



#take a video2
rpicam-vid -t 5s --width 1280 --height 720 --vflip --hflip --brightness 0.2 -o script03/vid03.mp4
 
r_n=$((RANDOM % 11 - 10))
rn=$((RANDOM % 10))
rnu=$((RANDOM % 500))
#stutter frames
ffmpeg -i script03/vid03.mp4 -vf "hue=s=$r_n:b=-2, random=frames=35:seed=$rn"  -pix_fmt yuv420p script03/vid04.mp4

#play
ffplay -i script03/vid04.mp4 -fs -autoexit


#take a vide0
rpicam-vid -t 5s --width 1280 --height 720 --vflip --hflip --brightness 0.2 -o script03/vid05.mp4

r_n=$((RANDOM % 11 - 10))
rn=$((RANDOM % 10))
#stutter frames
ffmpeg -i script03/vid05.mp4 -vf "hue=s=$r_n:b=-2, random=frames=30:seed=$rn"  -pix_fmt yuv420p script03/vid06.mp4

#play
ffplay -i script03/vid06.mp4 -fs -autoexit




rm -rf script03

