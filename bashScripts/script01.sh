#!/bin/bash

# A hue and saturation script


#make a dir
mkdir script01

#sleep 2

# take a 5 video

rpicam-vid -n -t 3s --width 1280 --height 720 --vflip --saturation 2.0  -o script01/script01vid.mp4

# process the file 1st time
ffmpeg -i script01/script01vid.mp4 -vf "hue=h=180:s=5" script01/script01vidproc1.mp4

#remove the original file
rm script01/script01vid.mp4

#play the processed file
ffplay -i script01/script01vidproc1.mp4 -fs -autoexit


#process a second time
ffmpeg -i script01/script01vidproc1.mp4 -vf "hue=h=-190:s=5" script01/script01vidproc2.mp4


#play the file
ffplay -i script01/script01vidproc2.mp4 -fs -autoexit

#process a 3rd time

ffmpeg -i script01/script01vidproc2.mp4 -vf "hue=h=90:s=5" script01/script01vidproc3.mp4

#play the file

ffplay -i script01/script01vidproc3.mp4 -fs -autoexit


#process a 4thtime

ffmpeg -i script01/script01vidproc3.mp4 -vf "hue=h=180:s=10" script01/script01vidproc4.mp4

#play the file

ffplay -i script01/script01vidproc4.mp4 -fs -autoexit

#process a 5th time

ffmpeg -i script01/script01vidproc4.mp4 -vf "hue=h=-80:s=-3" script01/script01vidproc5.mp4

#play the file

ffplay -i script01/script01vidproc5.mp4 -fs -autoexit





#remove the processed file
rm -rf script01

#rm script01/script01vidproc1.mp4
#rm script01/script01vidproc2.mp4
#rm script01/script01vidproc3.mp4
