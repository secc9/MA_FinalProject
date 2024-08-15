#!/bin/bash



mkdir s08



rpicam-vid -t 5s --width 1280 --height 720 --vflip -o s08/vid1.mp4


ffmpeg -i s08/vid1.mp4 -vf "sobel" s08/vid2.mp4

ffplay -i s08/vid2.mp4 -fs -autoexit

ffmpeg -i s08/vid2.mp4 -vf "sobel" s08/vid3.mp4

ffplay -i s08/vid3.mp4 -fs -autoexit

ffmpeg -i s08/vid3.mp4 -vf "sobel" s08/vid4.mp4

ffplay -i s08/vid4.mp4 -fs -autoexit

ffmpeg -i s08/vid4.mp4 -vf "sobel" s08/vid5.mp4

ffplay -i s08/vid5.mp4 -fs -autoexit

ffmpeg -i s08/vid5.mp4 -vf "sobel" s08/vid6.mp4

ffplay -i s08/vid6.mp4 -fs -autoexit

ffmpeg -i s08/vid6.mp4 -vf "sobel" s08/vid7.mp4

ffplay -i s08/vid7.mp4 -fs -autoexit

ffmpeg -i s08/vid7.mp4 -vf "sobel" s08/vid8.mp4

ffplay -i s08/vid8.mp4 -fs -autoexit

ffmpeg -i s08/vid8.mp4 -vf "sobel" s08/vid9.mp4

ffplay -i s08/vid9.mp4 -fs -autoexit

ffmpeg -i s08/vid9.mp4 -vf "sobel" s08/vid10.mp4

ffplay -i s08/vid10.mp4 -fs -autoexit




rm -rf s08
