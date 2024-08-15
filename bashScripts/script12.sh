#!/bin/bash


#hrotate

mkdir s12

rpicam-vid -t 7s --width 1280 --height 720 --vflip -o s12/vid1.mp4

rnA=$((RANDOM % 1024 + 1))
rnB=$((RANDOM % 1024 + 1))
rnC=$((RANDOM % 21 + 1 ))
rnD=$((RANDOM % 14 + 1))
rnE=$((RANDOM % 14 + 1))
rnF=$((RANDOM % 14 + 1 ))
ffmpeg -i s12/vid1.mp4 -vf "sobel=planes=$rnD, sobel=planes=$rnE, pixelize=w=$rnA:h=$rnB:m=avg:p=$rnC,sobel=planes=$rnF,sobel" s12/vid2.mp4


ffplay -i s12/vid2.mp4 -fs -autoexit

rm -rf s12 
